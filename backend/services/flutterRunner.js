/**
 * flutterRunner.js — Spawn flutter run -d chrome, capture stdout/stderr,
 * relay stdin commands, emit events.
 *
 * Key additions:
 * - onDebugServiceReady({ port, wsUrl }) — emitted when Flutter debug service is live
 * - onAppReady(url) — emitted when web server URL detected
 * Both replace the old 3s blind setTimeout for instrumentation.
 */

const { spawn } = require('child_process');
const path = require('path');
const treeKill = require('tree-kill');
const logParser = require('./logParser');
const envManager = require('./envManager');
const telemetry = require('./telemetry');

/**
 * Run a Flutter project in Chrome.
 *
 * @param {string} projectDir - Absolute path to the Flutter project
 * @param {object} handlers
 *   onLog(entry)                         - called for every log line
 *   onDevToolsUrl(url)                   - called when DevTools URL detected
 *   onDebugServiceReady({ port, wsUrl }) - called when debug service is live ← NEW
 *   onStateUpdate(data)                  - called for AppState events
 *   onApiCall(data)                      - called for ApiManager events
 *   onWidgetUpdate(data)                 - called for WidgetTree events
 *   onAppReady(url)                      - called when web server URL appears
 *   onExit(code)                         - called when process exits
 *
 * @returns {{ sendInput(str), kill(), pid }}
 */
function run(projectDir, handlers = {}) {
    const {
        onLog = () => { },
        onDevToolsUrl = () => { },
        onDebugServiceReady = () => { },  // ← NEW
        onAppReady = () => { },
        onExit = () => { }
    } = handlers;

    const flutterBin = envManager.resolveFlutterBin();

    const args = ['run', '-d', 'chrome', '--no-pub'];
    console.log(`[FlutterRunner] spawn: ${flutterBin} ${args.join(' ')} in ${projectDir}`);

    const proc = spawn(flutterBin, args, {
        cwd: projectDir,
        shell: true,
        env: { ...process.env }
    });

    let devToolsEmitted = false;
    let debugServiceEmitted = false;  // ← prevent double-emit
    let appReadyEmitted = false;
    let lineBuf = '';

    function processLine(rawLine) {
        const line = rawLine.trim();
        if (!line) return;

        const entry = logParser.parseLine(line);

        // Classify compilation errors
        if (line.includes('Error:') || line.includes('Failure') || line.includes('Unhandled exception:')) {
            entry.level = 'error';
            entry.isCompilationError = true;
        }

       
        // ── DevTools URL ──────────────────────────────────────────────
        if (entry.devToolsUrl && !devToolsEmitted) {
            devToolsEmitted = true;
            onDevToolsUrl(entry.devToolsUrl);
        }

        // ── Debug Service Port ◄ NEW ──────────────────────────────────
        // "Debug service listening on ws://127.0.0.1:58536/.../ws"
        if (!debugServiceEmitted) {
            const ds = logParser.parseDebugServicePort(line);
            if (ds) {
                debugServiceEmitted = true;
                console.log(`[FlutterRunner] Debug service ready: port ${ds.port}, wsUrl ${ds.wsUrl}`);
                onDebugServiceReady(ds);
            }
        }

        // ── App Web Server URL ─────────────────────────────────────────
        // "http://127.0.0.1:PORT" line signals the Flutter web server is up
        if (!appReadyEmitted && (line.includes('Serving at') || line.includes('DevTools available at'))) {
            const match = line.match(/http:\/\/127\.0\.0\.1:(\d+)/);
            if (match) {
                appReadyEmitted = true;
                const port = match[1];
                const url = `http://localhost:${port}`;
                onLog({ level: 'info', message: `🌐 Flutter Web server detected: ${url}`, timestamp: Date.now() });
                onAppReady(url);

                try {
                    const open = require('open');
                    open(url);
                    onLog({ level: 'info', message: '🚀 Chrome launched automatically.', timestamp: Date.now() });
                } catch (e) {
                    onLog({ level: 'warn', message: `⚠️ Failed to auto-open Chrome: ${e.message}`, timestamp: Date.now() });
                }
            }
        }

        // ── Supabase log-based detection (optional legacy kept if needed) ──
        const supabase = logParser.parseSupabaseQuery(line);
        if (supabase) {
            telemetry.recordSupabaseQuery('flutter-app', supabase.table, supabase.operation, supabase.duration);
        }

        // All other telemetry is now handled natively via the Dart VM Service WebSockets.
    }

    function streamHandler(chunk) {
        const text = chunk.toString();
        lineBuf += text;
        const lines = lineBuf.split('\n');
        lineBuf = lines.pop();
        lines.forEach(processLine);
    }

    proc.stdout.on('data', streamHandler);
    proc.stderr.on('data', streamHandler);

    proc.on('close', (code) => {
        if (lineBuf.trim()) processLine(lineBuf);
        onExit(code);
    });

    proc.on('error', (err) => {
        onLog({ level: 'error', message: `[FlutterRunner] Process error: ${err.message}`, timestamp: Date.now() });
    });

    return {
        sendInput(str) {
            if (proc && proc.stdin && !proc.stdin.destroyed) {
                proc.stdin.write(`${str}\n`);
            }
        },
        kill() {
            if (proc && proc.pid) {
                if (process.platform === 'win32') {
                    const { execSync } = require('child_process');
                    try { execSync(`taskkill /F /T /PID ${proc.pid}`); } catch (e) { }
                } else {
                    treeKill(proc.pid, 'SIGTERM');
                }
            }
        },
        get pid() { return proc ? proc.pid : null; }
    };
}

module.exports = { run };
