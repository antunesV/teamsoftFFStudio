/**
 * cliResolver.js — Robust FlutterFlow CLI detection and resolution
 * Resolves flutterflow-cli using PATH, dart pub, and APPDATA bundled fallbacks.
 */

const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');

let cachedCLIResult = null;

const IS_WIN = process.platform === 'win32';

let detectedDartBinPath = null;

/**
 * Sets the dart binary path to be used for sub-commands.
 */
function setDartBinPath(p) {
    if (!p) return;
    detectedDartBinPath = path.dirname(p.replace(/\"/g, ''));
}

/**
 * Runs a command synchronously, returns trimmed stdout or null on failure.
 */
function runCmd(cmd) {
    try {
        const env = getCLIEnv();

        let finalCmd = cmd;
        if (IS_WIN) {
            // Force use of cmd /c for better batch file handling
            finalCmd = `cmd /c ${cmd}`;
        }

        return execSync(finalCmd, { encoding: 'utf8', stdio: 'pipe', env }).trim();
    } catch (e) {
        if (e.stderr) console.error(`[cliResolver] runCmd failed: ${cmd}\nSTDERR: ${e.stderr.toString().trim()}`);
        else if (e.message) console.error(`[cliResolver] runCmd failed: ${cmd}\nERROR: ${e.message.trim()}`);
        return null;
    }
}

/**
 * Returns the environment variables to be used for CLI commands.
 */
function getCLIEnv() {
    const env = { ...process.env };
    let currentPath = env.PATH || env.Path || '';

    // Ensure critical system paths are present on Windows
    if (IS_WIN) {
        const systemPaths = [
            'C:\\Windows\\system32',
            'C:\\Windows',
            'C:\\Windows\\System32\\Wbem',
            'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\'
        ];
        for (const p of systemPaths) {
            if (!currentPath.toLowerCase().includes(p.toLowerCase())) {
                currentPath = `${p}${path.delimiter}${currentPath}`;
            }
        }
    }

    if (detectedDartBinPath) {
        if (!currentPath.toLowerCase().includes(detectedDartBinPath.toLowerCase())) {
            currentPath = `${detectedDartBinPath}${path.delimiter}${currentPath}`;
        }
    }

    env.PATH = currentPath;
    env.Path = currentPath;
    return env;
}

/**
 * 1. Check system PATH (standard 'where' lookup)
 */
function checkSystemPathCLI() {
    console.log('[cliResolver] [1] Checking system PATH for flutterflow...');
    const v = runCmd('flutterflow --version');
    if (v) return { method: 'system_path', bin: 'flutterflow', version: v };
    return null;
}

/**
 * 2. Check Dart Global Pub
 */
function checkDartGlobalCLI() {
    console.log('[cliResolver] Checking Dart Global Pub for flutterflow_cli...');

    // Phase 7: High-priority check for known Windows Pub Cache location
    if (IS_WIN) {
        const pubCacheDir = path.join(os.homedir(), 'AppData', 'Local', 'Pub', 'Cache', 'bin');
        const fullBinPath = path.join(pubCacheDir, 'flutterflow.bat');
        if (fs.existsSync(fullBinPath)) {
            console.log(`[cliResolver] [P7] Found binary in pub cache (fast-path): ${fullBinPath}`);
            return { method: 'dart_pub_global_fast', bin: `"${fullBinPath}"`, version: 'resolved' };
        }
    }

    // Attempt to find dart
    let dartBin = 'dart';
    let dartVersion = runCmd('dart --version');

    if (!dartVersion) {
        console.log('[cliResolver] dart not in PATH, checking common locations...');
        const userHome = os.homedir();
        const searchPaths = [
            path.join(userHome, 'AppData', 'Roaming', 'FlutterFlow', 'flutterflow', 'flutter', 'bin', 'cache', 'dart-sdk', 'bin'),
            path.join(userHome, 'AppData', 'Roaming', 'FlutterFlow', 'flutterflow', 'flutter', 'bin'),
            path.join(userHome, 'flutter', 'bin'),
            'C:\\flutter\\bin',
            'C:\\src\\flutter\\bin',
            path.join(process.env.LOCALAPPDATA || '', 'Pub', 'Cache', 'bin'),
        ];

        for (const sp of searchPaths) {
            const d = path.join(sp, IS_WIN ? 'dart.exe' : 'dart');
            if (fs.existsSync(d)) {
                console.log(`[cliResolver] Potential dart found at: ${d}`);
                detectedDartBinPath = sp; // Set this so runCmd can use it!
                dartBin = `"${d}"`;
                dartVersion = runCmd(`${dartBin} --version`);
                if (dartVersion) {
                    console.log(`[cliResolver] Verified dart in search path: ${sp}`);
                    break;
                } else {
                    detectedDartBinPath = null; // Reset if failed
                }
            }
        }
    }

    if (!dartVersion) {
        console.log('[cliResolver] Could not find dart.');
        return null;
    }

    setDartBinPath(dartBin);

    // Check if flutterflow_cli is activated
    const pubGlobalList = runCmd(`${dartBin} pub global list`);
    console.log(`[cliResolver] pub global list: ${pubGlobalList ? 'success' : 'failed'}`);

    let version = 'unknown';
    if (pubGlobalList && pubGlobalList.includes('flutterflow_cli')) {
        const match = pubGlobalList.match(/flutterflow_cli\s+([^\s]+)/);
        if (match) version = match[1];
    } else {
        console.log('[cliResolver] flutterflow_cli NOT in global list. Activating...');
        const activate = runCmd(`${dartBin} pub global activate flutterflow_cli`);
        if (!activate) {
            console.log('[cliResolver] Activation failed.');
            return null;
        }
        // Re-read version after activation
        const updatedList = runCmd(`${dartBin} pub global list`);
        const match = updatedList ? updatedList.match(/flutterflow_cli\s+([^\s]+)/) : null;
        if (match) version = match[1];
    }

    // Attempt to resolve binary path
    const pubCacheDir = IS_WIN
        ? path.join(os.homedir(), 'AppData', 'Local', 'Pub', 'Cache', 'bin')
        : path.join(os.homedir(), '.pub-cache', 'bin');

    const binName = IS_WIN ? 'flutterflow.bat' : 'flutterflow';
    const fullBinPath = path.join(pubCacheDir, binName);

    if (fs.existsSync(fullBinPath)) {
        console.log(`[cliResolver] [2] Found binary in pub cache: ${fullBinPath}`);
        return { method: 'dart_pub_global', bin: `"${fullBinPath}"`, version: version };
    } else {
        console.log('[cliResolver] binary NOT in pub cache bin folder. Trying run...');
        // Verify we can at least run it
        const help = runCmd(`${dartBin} pub global run flutterflow_cli --help`);
        if (help) return { method: 'dart_pub_global_run', bin: `${dartBin} pub global run flutterflow_cli`, version: version };
    }
    return null;
}

/**
 * 3. Check Local node_modules bin (e.g. if installed via npm devDependency)
 */
function checkLocalBinCLI() {
    console.log('[cliResolver] [3] Checking local node_modules/.bin for flutterflow...');
    const localBin = path.join(process.cwd(), 'node_modules', '.bin', IS_WIN ? 'flutterflow.cmd' : 'flutterflow');
    if (fs.existsSync(localBin)) {
        const v = runCmd(`"${localBin}" --version`);
        if (v) return { method: 'local_node_modules', bin: `"${localBin}"`, version: v };
    }
    return null;
}

/**
 * 3. Fallback to bundled FlutterFlow SDK
 */
function checkBundledCLI() {
    console.log('[cliResolver] Checking bundled FlutterFlow SDK...');
    const appDataBin = IS_WIN
        ? path.join(os.homedir(), 'AppData', 'Roaming', 'FlutterFlow', 'flutterflow', 'flutterflow.exe')
        : path.join(os.homedir(), 'Library', 'Application Support', 'FlutterFlow', 'flutterflow', 'flutterflow');

    if (fs.existsSync(appDataBin)) {
        console.log(`[cliResolver] Found bundled SDK: ${appDataBin}`);
        // Try --version, fallback to --help
        let v = runCmd(`"${appDataBin}" --version`);
        if (!v) v = 'found'; // If it exists but --version fails, we still count it
        return { method: 'bundled', bin: `"${appDataBin}"`, version: v };
    }

    return null;
}

/**
 * Resolves the FlutterFlow CLI.
 * Tries PATH -> dart pub global -> bundled -> API fallback
 */
function resolveFlutterFlowCLI() {
    if (cachedCLIResult) {
        return cachedCLIResult;
    }

    console.log('[cliResolver] Resolving flutterflow-cli...');

    let result = checkSystemPathCLI();
    if (result) {
        console.log(`[cliResolver] Success (PATH): ${result.version}`);
        cachedCLIResult = result;
        return result;
    }

    result = checkDartGlobalCLI();
    if (result) {
        console.log(`[cliResolver] Success (Dart Pub): ${result.version}`);
        cachedCLIResult = result;
        return result;
    }

    result = checkLocalBinCLI();
    if (result) {
        console.log(`[cliResolver] Success (Local): ${result.version}`);
        cachedCLIResult = result;
        return result;
    }

    result = checkBundledCLI();
    if (result) {
        console.log(`[cliResolver] Success (Bundled): ${result.version}`);
        cachedCLIResult = result;
        return result;
    }

    console.log('[cliResolver] ALL resolution methods failed.');
    cachedCLIResult = { method: 'api_fallback', bin: null, version: null };
    return cachedCLIResult;
}

function clearCache() {
    cachedCLIResult = null;
}

module.exports = {
    resolveFlutterFlowCLI,
    checkSystemPathCLI,
    checkDartGlobalCLI,
    checkLocalBinCLI,
    checkBundledCLI,
    getCLIEnv,
    clearCache
};
