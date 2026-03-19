/**
 * projectExporter.js — Parses FlutterFlow export commands and automates project export
 */

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');
const axios = require('axios');
const decompress = require('decompress');
const logInjector = require('./logInjector');
const cliResolver = require('./cliResolver');

const PROJECTS_DIR = path.join(os.homedir(), '.teamsoft-ff-localrun', 'projects');

function ensureProjectsDir() {
    if (!fs.existsSync(PROJECTS_DIR)) fs.mkdirSync(PROJECTS_DIR, { recursive: true });
}

function findProjectRoot(destDir) {
    if (fs.existsSync(path.join(destDir, 'pubspec.yaml'))) return destDir;
    const subs = fs.readdirSync(destDir);
    for (const sub of subs) {
        const full = path.join(destDir, sub);
        if (fs.statSync(full).isDirectory() && fs.existsSync(path.join(full, 'pubspec.yaml'))) {
            return full;
        }
    }
    return destDir; 
}

function getMetadata(destDir) {
    const metaPath = path.join(destDir, '.ff_metadata.json');
    if (fs.existsSync(metaPath)) {
        try { return JSON.parse(fs.readFileSync(metaPath, 'utf8')); } catch (e) { return null; }
    }
    return null;
}

function saveMetadata(destDir, data) {
    const metaPath = path.join(destDir, '.ff_metadata.json');
    fs.writeFileSync(metaPath, JSON.stringify({ ...data, lastExport: Date.now() }, null, 2));
}

function parseCommand(commandStr) {
    const parts = commandStr.trim().split(/\s+/);
    const result = { projectId: null, token: null, branch: null, environment: null, dest: null, force: true, args: [], flags: {} }; // <-- force: true

    let i = 0;
    while (i < parts.length && !parts[i].startsWith('--')) i++;

    while (i < parts.length) {
        if (parts[i].startsWith('--')) {
            const key = parts[i].replace(/^--/, '');
            const val = parts[i + 1] && !parts[i + 1].startsWith('--') ? parts[i + 1] : 'true';
            result.flags[key] = val;
            if (key === 'project' || key === 'p') result.projectId = val;
            if (key === 'token' || key === 't') result.token = val;
            if (key === 'branch-name') result.branch = val;
            if (key === 'project-environment') result.environment = val;
            if (key === 'dest' || key === 'd') result.dest = val;
            if (key === 'force-export') result.force = true;
            if (val !== 'true') i++;
        }
        i++;
    }
    return result;
}

async function fallbackToExportAPI(parsedOptions, destDir, onStatus) {
    onStatus('⚠️ Initiating REST API fallback for export (CLI unavailable)...');
    if (!parsedOptions.projectId || !parsedOptions.token) throw new Error('Project ID and Token are required.');

    try {
        const exportUrl = `https://api.flutterflow.io/v1/projects/${parsedOptions.projectId}/export`;
        const response = await axios.post(exportUrl, {
            branchName: parsedOptions.branch || 'main',
            environment: parsedOptions.environment || 'Development'
        }, { headers: { 'Authorization': `Bearer ${parsedOptions.token}` } });

        const downloadUrl = response.data.downloadUrl;
        if (!downloadUrl) throw new Error('FlutterFlow API did not return a download URL.');

        onStatus(`📥 Downloading ZIP from: ${downloadUrl}`);
        const zipPath = path.join(os.tmpdir(), `ff_export_${parsedOptions.projectId}.zip`);
        const writer = fs.createWriteStream(zipPath);

        const zipResponse = await axios({ url: downloadUrl, method: 'GET', responseType: 'stream' });
        zipResponse.data.pipe(writer);

        await new Promise((resolve, reject) => {
            writer.on('finish', resolve);
            writer.on('error', reject);
        });

        onStatus(`📦 Extracting project to: ${destDir}`);
        await decompress(zipPath, destDir);
        if (fs.existsSync(zipPath)) fs.unlinkSync(zipPath);

        onStatus('✅ REST API Export successful.');
        await logInjector.inject(destDir, (m) => onStatus(`[LogInjector] ${m}`));
        return destDir;
    } catch (err) {
        throw new Error(`REST API fallback failed: ${err.message}`);
    }
}

// 🚀 SISTEMA DE RETRY AUTOMÁTICO (Blindagem contra quedas do FlutterFlow)
async function _runCliWithRetry(cliBin, cliArgs, env, destDir, parsed, injectLogs, onStatus, maxRetries = 3) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            return await new Promise((resolve, reject) => {
                let proc;
                if (cliBin.startsWith('npx ')) {
                    const [npx, ...rest] = cliBin.split(' ');
                    proc = spawn(npx, [...rest, ...cliArgs], { shell: true, env });
                } else {
                    const bin = cliBin.replace(/(^"|"$)/g, '');
                    proc = spawn(bin, cliArgs, { shell: true, env });
                }

                let errorBuffer = '';

                proc.stdout.on('data', (d) => onStatus(d.toString().trim()));
                proc.stderr.on('data', (d) => {
                    const str = d.toString().trim();
                    errorBuffer += str + ' ';
                    onStatus(`[stderr] ${str}`);
                });

                proc.on('close', async (code) => {
                    const actualRoot = findProjectRoot(destDir);
                    // Se deu código 0 OU se o arquivo pubspec.yaml existe (mesmo com erro bobo), consideramos sucesso!
                    if (code === 0 || fs.existsSync(path.join(actualRoot, 'pubspec.yaml'))) {
                        
                        // Se falhou severamente (ex: API 400) mas sobrou a pasta velha, forçamos o erro para tentar de novo
                        if (code !== 0 && errorBuffer.includes('Unexpected error from the server') && errorBuffer.includes('400')) {
                            return reject(new Error('FlutterFlow Server 400 Error'));
                        }

                        onStatus(`✅ Project exported to: ${actualRoot}`);
                        saveMetadata(destDir, { projectId: parsed.projectId, branch: parsed.branch || 'main' });

                        if (injectLogs) {
                            await logInjector.inject(actualRoot, (m) => onStatus(`[LogInjector] ${m}`));
                        }
                        resolve(actualRoot);
                    } else {
                        reject(new Error(`FlutterFlow CLI exited with code ${code}`));
                    }
                });

                proc.on('error', (err) => reject(err));
            });
        } catch (err) {
            if (attempt < maxRetries) {
                onStatus(`⚠️ Export failed. Retrying in 3 seconds... (Attempt ${attempt + 1}/${maxRetries})`);
                await new Promise(res => setTimeout(res, 3000));
            } else {
                onStatus(`❌ CLI execution error after ${maxRetries} attempts: ${err.message}`);
                throw err;
            }
        }
    }
}

async function exportProject(commandStr, onStatus, injectLogs = false) {
    ensureProjectsDir();
    const parsed = parseCommand(commandStr);

    const projectId = parsed.projectId || 'unknown_project';
    const destDir = parsed.dest || path.join(PROJECTS_DIR, projectId);

    if (!fs.existsSync(destDir)) fs.mkdirSync(destDir, { recursive: true });

    const cliResolution = cliResolver.resolveFlutterFlowCLI();

    if (cliResolution.method === 'api_fallback') {
        return await fallbackToExportAPI(parsed, destDir, onStatus);
    }

    const cliArgs = ['export-code'];
    if (parsed.projectId) cliArgs.push('--project', parsed.projectId);
    if (parsed.token) cliArgs.push('--token', parsed.token);
    if (parsed.branch) cliArgs.push('--branch-name', parsed.branch);
    if (parsed.environment) cliArgs.push('--project-environment', parsed.environment);
    cliArgs.push('--include-assets');
    cliArgs.push('--dest', destDir);

    const cliBin = cliResolution.bin;
    const env = cliResolver.getCLIEnv();
    onStatus(`▶  Running exporter: ${cliBin} ${cliArgs.join(' ')}`);

    return _runCliWithRetry(cliBin, cliArgs, env, destDir, parsed, injectLogs, onStatus);
}

module.exports = { exportProject, parseCommand, fallbackToExportAPI, PROJECTS_DIR };