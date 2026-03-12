/**
 * envManager.js — Fast Environment Detection and Auto-installer
 * Caches results in .ff-studio-env.json to achieve < 2s startup.
 */

const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');
const https = require('https');
const http = require('http');

const TOOLS_DIR = path.join(os.homedir(), '.teamsoft-ff-localrun', 'tools');
const CACHE_FILE = path.join(os.homedir(), '.teamsoft-ff-localrun', '.ff-studio-env.json');
const IS_WIN = process.platform === 'win32';
const IS_MAC = process.platform === 'darwin';

// ─── Caching System ───────────────────────────────────────────────────────────

let envCache = null;

function loadCache() {
    if (envCache) return envCache;
    try {
        if (fs.existsSync(CACHE_FILE)) {
            const data = fs.readFileSync(CACHE_FILE, 'utf8');
            envCache = JSON.parse(data);
            return envCache;
        }
    } catch (e) {
        // ignore parse error
    }
    envCache = {
        node: null,
        git: null,
        flutter: null,
        dart: null,
        chrome: null,
        androidSdk: null,
        java: null,
        flutterflowCLI: null,
        lastChecked: null
    };
    return envCache;
}

function saveCache() {
    if (!envCache) return;
    try {
        if (!fs.existsSync(path.dirname(CACHE_FILE))) {
            fs.mkdirSync(path.dirname(CACHE_FILE), { recursive: true });
        }
        envCache.lastChecked = Date.now();
        fs.writeFileSync(CACHE_FILE, JSON.stringify(envCache, null, 2), 'utf8');
    } catch (e) {
        console.warn('Failed to save env cache', e);
    }
}

function clearCache() {
    envCache = null;
    if (fs.existsSync(CACHE_FILE)) {
        fs.unlinkSync(CACHE_FILE);
    }
}

function ensureToolsDir() {
    if (!fs.existsSync(TOOLS_DIR)) fs.mkdirSync(TOOLS_DIR, { recursive: true });
}

function runCmd(cmd, options = {}) {
    try {
        const result = execSync(cmd, { encoding: 'utf8', timeout: 5000, stdio: 'pipe', ...options });
        return result.trim();
    } catch (e) {
        return null;
    }
}

// ─── Individual Checks (cached) ───────────────────────────────────────────────

function checkNode(force = false) {
    const cache = loadCache();
    if (!force && cache.node && cache.node.installed) return cache.node;

    const v = runCmd('node -v');
    const result = v ? { installed: true, version: v } : { installed: false };
    cache.node = result;
    return result;
}

function checkGit(force = false) {
    const cache = loadCache();
    if (!force && cache.git && cache.git.installed) return cache.git;

    const v = runCmd('git --version');
    const result = v ? { installed: true, version: v } : { installed: false };
    cache.git = result;
    return result;
}

function checkFlutter(force = false) {
    const cache = loadCache();
    if (!force && cache.flutter && cache.flutter.installed && fs.existsSync(cache.flutter.path || '')) {
        return cache.flutter; // Fast path if we already resolved the absolute path
    }

    let result = { installed: false };

    // 1. Check system Flutter
    const sysV = runCmd('flutter --version');
    if (sysV) {
        // Try to get actual path
        const whereCmd = IS_WIN ? 'where flutter' : 'which flutter';
        const p = runCmd(whereCmd);
        result = { installed: true, version: sysV.split('\n')[0], path: p ? p.split('\n')[0] : 'flutter', source: 'system' };
    } else {
        // 2. Check FlutterFlow bundled Flutter
        const ffFlutterPaths = IS_WIN
            ? [
                path.join(os.homedir(), 'AppData', 'Roaming', 'FlutterFlow', 'flutterflow', 'flutter', 'bin', 'flutter.bat'),
            ]
            : [
                path.join(os.homedir(), 'Library', 'Application Support', 'FlutterFlow', 'flutterflow', 'flutter', 'bin', 'flutter'),
                path.join(os.homedir(), '.local', 'share', 'FlutterFlow', 'flutterflow', 'flutter', 'bin', 'flutter'),
            ];

        for (const p of ffFlutterPaths) {
            if (fs.existsSync(p)) {
                // Try to get version from the bundled one
                const v = runCmd(`"${p}" --version`);
                result = { installed: true, version: v ? v.split('\n')[0] : 'bundled', path: p, source: 'flutterflow-bundled' };
                break;
            }
        }

        // 3. Check local tools dir
        if (!result.installed) {
            const toolsFlutter = path.join(TOOLS_DIR, 'flutter', 'bin', IS_WIN ? 'flutter.bat' : 'flutter');
            if (fs.existsSync(toolsFlutter)) {
                const v = runCmd(`"${toolsFlutter}" --version`);
                result = { installed: true, version: v ? v.split('\n')[0] : 'tools', path: toolsFlutter, source: 'tools-dir' };
            }
        }
    }

    cache.flutter = result;
    return result;
}

function checkDart(force = false) {
    const cache = loadCache();
    if (!force && cache.dart && cache.dart.installed) return cache.dart;

    let result = { installed: false };
    const v = runCmd('dart --version');
    if (v) {
        result = { installed: true, version: v };
    } else {
        // Check same place as flutter
        const flutter = checkFlutter();
        if (flutter.installed && flutter.path) {
            const dartPath = path.join(path.dirname(flutter.path), IS_WIN ? 'dart.bat' : 'dart');
            if (fs.existsSync(dartPath)) {
                const dv = runCmd(`"${dartPath}" --version`);
                result = { installed: true, version: dv || 'bundled', path: dartPath };
            }
        }
    }

    cache.dart = result;
    return result;
}

function checkChrome(force = false) {
    const cache = loadCache();
    if (!force && cache.chrome && cache.chrome.installed) return cache.chrome;

    let result = { installed: false };
    if (IS_WIN) {
        const chromePath = path.join(process.env['ProgramFiles'] || 'C:\\Program Files', 'Google', 'Chrome', 'Application', 'chrome.exe');
        const chromePath86 = path.join(process.env['ProgramFiles(x86)'] || 'C:\\Program Files (x86)', 'Google', 'Chrome', 'Application', 'chrome.exe');
        if (fs.existsSync(chromePath)) result = { installed: true, path: chromePath };
        else if (fs.existsSync(chromePath86)) result = { installed: true, path: chromePath86 };
    } else if (IS_MAC) {
        const chromeApp = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
        if (fs.existsSync(chromeApp)) result = { installed: true, path: chromeApp };
    } else {
        const v = runCmd('google-chrome --version');
        if (v) result = { installed: true, version: v };
    }

    cache.chrome = result;
    return result;
}

function checkAndroidSdk(force = false) {
    const cache = loadCache();
    if (!force && cache.androidSdk && cache.androidSdk.installed) return cache.androidSdk;

    let result = { installed: false };
    const sdkPath = IS_WIN
        ? path.join(os.homedir(), 'AppData', 'Local', 'Android', 'Sdk')
        : path.join(os.homedir(), 'Library', 'Android', 'sdk');

    if (fs.existsSync(sdkPath)) {
        result = { installed: true, path: sdkPath };
    }

    cache.androidSdk = result;
    return result;
}

function checkJava(force = false) {
    const cache = loadCache();
    if (!force && cache.java && cache.java.installed) return cache.java;

    const v = runCmd('java -version');
    const result = v ? { installed: true, version: 'found' } : { installed: false };
    cache.java = result;
    return result;
}

function checkFlutterFlowCLI(force = false) {
    const cache = loadCache();
    if (!force && cache.flutterflowCLI && cache.flutterflowCLI.installed) {
        // Just verify the CLI module agrees
        const cliResolver = require('./cliResolver');
        const resolved = cliResolver.resolveFlutterFlowCLI();
        if (resolved && resolved.method !== 'api_fallback') {
            return cache.flutterflowCLI;
        }
    }

    const cliResolver = require('./cliResolver');
    const resolved = cliResolver.resolveFlutterFlowCLI();

    const result = (resolved && resolved.method !== 'api_fallback')
        ? { installed: true, method: resolved.method, version: resolved.version || 'unknown' }
        : { installed: false };

    cache.flutterflowCLI = result;
    return result;
}

// ─── Full Check ─────────────────────────────────────────────────────────────

async function check(force = false) {
    const results = {
        node: checkNode(force),
        git: checkGit(force),
        flutter: checkFlutter(force),
        dart: checkDart(force),
        chrome: checkChrome(force),
        androidSdk: checkAndroidSdk(force),
        java: checkJava(force),
        flutterflowCLI: checkFlutterFlowCLI(force)
    };
    saveCache();
    return results;
}

// ─── Installers & ensuring ────────────────────────────────────────────────────

function downloadFile(url, dest, onProgress) {
    return new Promise((resolve, reject) => {
        const proto = url.startsWith('https') ? https : http;
        const file = fs.createWriteStream(dest);
        proto.get(url, (response) => {
            if (response.statusCode === 301 || response.statusCode === 302) {
                file.close();
                fs.unlinkSync(dest);
                return downloadFile(response.headers.location, dest, onProgress).then(resolve).catch(reject);
            }
            const totalBytes = parseInt(response.headers['content-length'] || '0', 10);
            let received = 0;
            response.on('data', (chunk) => {
                received += chunk.length;
                if (totalBytes > 0 && onProgress) {
                    const pct = Math.round((received / totalBytes) * 100);
                    onProgress(pct, received, totalBytes);
                }
            });
            response.pipe(file);
            file.on('finish', () => { file.close(); resolve(dest); });
        }).on('error', (err) => {
            fs.unlink(dest, () => { });
            reject(err);
        });
    });
}

async function installFlutter(onStatus) {
    ensureToolsDir();
    const flutterDir = path.join(TOOLS_DIR, 'flutter');
    if (fs.existsSync(flutterDir)) {
        onStatus('✅ Flutter already in tools directory.');
        return path.join(flutterDir, 'bin', IS_WIN ? 'flutter.bat' : 'flutter');
    }

    onStatus('📥 Downloading Flutter SDK (this may take a few minutes)...');
    const FLUTTER_URLS = {
        win32: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip',
        darwin: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.19.6-stable.zip',
        linux: 'https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz'
    };

    const platform = IS_WIN ? 'win32' : IS_MAC ? 'darwin' : 'linux';
    const url = FLUTTER_URLS[platform];
    const zipPath = path.join(TOOLS_DIR, 'flutter-sdk.zip');

    await downloadFile(url, zipPath, (pct) => {
        onStatus(`📥 Downloading Flutter SDK (${pct}%)...`);
    });

    onStatus('📦 Extracting Flutter SDK...');
    const decompress = require('decompress');
    await decompress(zipPath, TOOLS_DIR);
    fs.unlinkSync(zipPath);

    onStatus('✅ Flutter SDK installed successfully.');

    // Clear cache to force redetection
    clearCache();
    return path.join(flutterDir, 'bin', IS_WIN ? 'flutter.bat' : 'flutter');
}

/**
 * High-speed ensure function. Only deeply checks and installs if Cache says it's missing.
 */
async function ensureAll(onStatus) {
    const start = Date.now();
    onStatus('🔍 Verifying environment (Fast Cache)...');

    // Attempt load from cache first
    const env = await check(false);

    if (!env.node.installed) {
        onStatus('⚠️ Node.js not found in PATH.');
    } else {
        onStatus(`✅ Node.js found.`);
    }

    if (!env.git.installed) {
        onStatus('⚠️ Git not found.');
    } else {
        onStatus(`✅ Git found.`);
    }

    if (!env.flutter.installed) {
        onStatus('📥 Flutter SDK not found. Installing...');
        try {
            const flutterPath = await installFlutter(onStatus);
            const binDir = path.dirname(flutterPath);
            process.env.PATH = `${binDir}${path.delimiter}${process.env.PATH}`;
            onStatus('✅ Flutter configured in PATH.');
            // Force re-check
            await check(true);
        } catch (err) {
            onStatus(`❌ Flutter install failed: ${err.message}`);
        }
    } else {
        if (env.flutter.path) {
            const binDir = path.dirname(env.flutter.path);
            process.env.PATH = `${binDir}${path.delimiter}${process.env.PATH}`;
            onStatus(`✅ Flutter found.`);
        }
    }

    if (!env.flutterflowCLI.installed) {
        onStatus('📦 FlutterFlow CLI not found. Attempting resolution...');
        const cliResolver = require('./cliResolver');

        // This will install locally via node_modules if completely missing
        cliResolver.clearCache();
        const resolved = cliResolver.resolveFlutterFlowCLI();

        if (resolved && resolved.method !== 'api_fallback') {
            onStatus(`✅ FlutterFlow CLI resolved via ${resolved.method}.`);
            await check(true);
        } else {
            onStatus('⚠️ FlutterFlow CLI could not be installed. Export will use API fallback.');
        }
    } else {
        onStatus(`✅ FlutterFlow CLI found.`);
    }

    const delta = Date.now() - start;
    onStatus(`✅ Environment checks complete in ${delta}ms.`);
}

function resolveFlutterBin() {
    const cache = loadCache();
    if (cache.flutter && cache.flutter.path) return cache.flutter.path;
    return IS_WIN ? 'flutter.bat' : 'flutter';
}

function resolveFlutterFlowBin() {
    const cliResolver = require('./cliResolver');
    const resolved = cliResolver.resolveFlutterFlowCLI();
    return resolved ? resolved.bin : 'flutterflow';
}

module.exports = {
    check,
    ensureAll,
    checkNode,
    checkGit,
    checkFlutter,
    checkDart,
    checkChrome,
    checkAndroidSdk,
    checkJava,
    checkFlutterFlowCLI,
    resolveFlutterBin,
    resolveFlutterFlowBin,
    clearCache,
    downloadFile,
    TOOLS_DIR
};
