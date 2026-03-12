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

    // Check immediate subdirectories
    const subs = fs.readdirSync(destDir);
    for (const sub of subs) {
        const full = path.join(destDir, sub);
        if (fs.statSync(full).isDirectory() && fs.existsSync(path.join(full, 'pubspec.yaml'))) {
            return full;
        }
    }
    return destDir; // Fallback to root if not found
}

/**
 * Simple metadata cache to skip redundant exports
 */
function getMetadata(destDir) {
    const metaPath = path.join(destDir, '.ff_metadata.json');
    if (fs.existsSync(metaPath)) {
        try {
            return JSON.parse(fs.readFileSync(metaPath, 'utf8'));
        } catch (e) {
            return null;
        }
    }
    return null;
}

function saveMetadata(destDir, data) {
    const metaPath = path.join(destDir, '.ff_metadata.json');
    fs.writeFileSync(metaPath, JSON.stringify({ ...data, lastExport: Date.now() }, null, 2));
}

/**
 * Parses flutterflow-cli or legacy flutterflow export strings.
 * e.g., flutterflow-cli export-code --project <id> --token <token>
 */
function parseCommand(commandStr) {
    const parts = commandStr.trim().split(/\s+/);
    const result = {
        projectId: null,
        token: null,
        branch: null,
        environment: null,
        dest: null,
        force: false,
        args: [],
        flags: {}
    };

    let i = 0;

    // Skip the binary/command stuff (e.g. "flutterflow-cli", "export-code")
    while (i < parts.length && !parts[i].startsWith('--')) {
        i++;
    }

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

/**
 * Attempt to export project using the FlutterFlow REST API as a fallback.
 */
async function fallbackToExportAPI(parsedOptions, destDir, onStatus) {
    onStatus('⚠️ Initiating REST API fallback for export (CLI unavailable)...');

    if (!parsedOptions.projectId || !parsedOptions.token) {
        throw new Error('Project ID and Token are required for REST API export.');
    }

    try {
        onStatus(`📡 Requesting export ZIP from FlutterFlow API for project: ${parsedOptions.projectId}...`);

        // FlutterFlow Export Endpoint (Standard CLI Fallback URL)
        const exportUrl = `https://api.flutterflow.io/v1/projects/${parsedOptions.projectId}/export`;

        const response = await axios.post(exportUrl, {
            branchName: parsedOptions.branch || 'main',
            environment: parsedOptions.environment || 'Development'
        }, {
            headers: { 'Authorization': `Bearer ${parsedOptions.token}` }
        });

        const downloadUrl = response.data.downloadUrl;
        if (!downloadUrl) {
            throw new Error('FlutterFlow API did not return a download URL.');
        }

        onStatus(`📥 Downloading ZIP from: ${downloadUrl}`);
        const zipPath = path.join(os.tmpdir(), `ff_export_${parsedOptions.projectId}.zip`);
        const writer = fs.createWriteStream(zipPath);

        const zipResponse = await axios({
            url: downloadUrl,
            method: 'GET',
            responseType: 'stream'
        });

        zipResponse.data.pipe(writer);

        await new Promise((resolve, reject) => {
            writer.on('finish', resolve);
            writer.on('error', reject);
        });

        onStatus(`📦 Extracting project to: ${destDir}`);
        await decompress(zipPath, destDir);

        // Clean up
        if (fs.existsSync(zipPath)) fs.unlinkSync(zipPath);

        onStatus('✅ REST API Export successful.');
        await logInjector.inject(destDir, (m) => onStatus(`[LogInjector] ${m}`));
        return destDir;
    } catch (err) {
        const errorMsg = err.response && err.response.data ? JSON.stringify(err.response.data) : err.message;
        onStatus(`❌ REST API Export failed: ${errorMsg}`);
        throw new Error(`REST API fallback failed: ${errorMsg}`);
    }
}

/**
 * Exports the FlutterFlow code.
 */
async function exportProject(commandStr, onStatus, injectLogs = false) {
    ensureProjectsDir();
    const parsed = parseCommand(commandStr);

    const projectId = parsed.projectId || 'unknown_project';
    const destDir = parsed.dest || path.join(PROJECTS_DIR, projectId);

    // Incremental check (TEMPORARILY DISABLED TO FORCE CLEAN DOWNLOAD)
    /*
    if (fs.existsSync(destDir) && !parsed.force) {
        const meta = getMetadata(destDir);
        if (meta && meta.projectId === projectId && meta.branch === (parsed.branch || 'main')) {
            const actualRoot = findProjectRoot(destDir);
            if (fs.existsSync(path.join(actualRoot, 'pubspec.yaml'))) {
                onStatus('⚡ Incremental export detected. Skipping CLI call.');
                onStatus(`Flutter root detected: ${actualRoot}`);
                if (injectLogs) {
                    await logInjector.inject(actualRoot, (m) => onStatus(`[LogInjector] ${m}`));
                }
                return actualRoot;
            }
        }
    }
    */

    if (!fs.existsSync(destDir)) fs.mkdirSync(destDir, { recursive: true });

    const cliResolution = cliResolver.resolveFlutterFlowCLI();

    if (cliResolution.method === 'api_fallback') {
        return await fallbackToExportAPI(parsed, destDir, onStatus);
    }

    // Build the correct arguments for flutterflow-cli
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

    return new Promise((resolve, reject) => {
        let proc;
        if (cliBin.startsWith('npx ')) {
            const [npx, ...rest] = cliBin.split(' ');
            proc = spawn(npx, [...rest, ...cliArgs], { shell: true, env });
        } else {
            // Strip quotes if any
            const bin = cliBin.replace(/(^"|"$)/g, '');
            proc = spawn(bin, cliArgs, { shell: true, env });
        }

        proc.stdout.on('data', (d) => onStatus(d.toString().trim()));
        proc.stderr.on('data', (d) => onStatus(`[stderr] ${d.toString().trim()}`));

        proc.on('close', async (code) => {
            const actualRoot = findProjectRoot(destDir);
            if (code === 0 || fs.existsSync(path.join(actualRoot, 'pubspec.yaml'))) {
                onStatus(`✅ Project exported to: ${actualRoot}`);
                onStatus(`Flutter root detected: ${actualRoot}`);

                // Save metadata for incremental next run
                saveMetadata(destDir, {
                    projectId: parsed.projectId,
                    branch: parsed.branch || 'main'
                });

                if (injectLogs) {
                    await logInjector.inject(actualRoot, (m) => onStatus(`[LogInjector] ${m}`));
                }
                resolve(actualRoot);
            } else {
                reject(new Error(`FlutterFlow CLI exited with code ${code}`));
            }
        });

        proc.on('error', (err) => {
            onStatus(`❌ CLI execution error: ${err.message}`);
            reject(err);
        });
    });
}

module.exports = { exportProject, parseCommand, fallbackToExportAPI, PROJECTS_DIR };
