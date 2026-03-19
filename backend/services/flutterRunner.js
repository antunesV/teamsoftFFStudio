/**
 * flutterRunner.js — Spawn flutter run -d chrome, capture stdout/stderr,
 * relay stdin commands, emit events.
 */

const { spawn } = require('child_process');
const path = require('path');
const treeKill = require('tree-kill');
const envManager = require('./envManager');

function run(projectDir, handlers = {}) {
    const {
        onLog = () => { },
        onDevToolsUrl = () => { },
        onDebugServiceReady = () => { },
        onAppReady = () => { },
        onExit = () => { }
    } = handlers;

    const flutterBin = envManager.resolveFlutterBin();
    const args = ['run', '-d', 'chrome', '--no-pub', '--web-server-debug-protocol=ws'];
    console.log(`[FlutterRunner] spawn: ${flutterBin} ${args.join(' ')} in ${projectDir}`);

    const proc = spawn(flutterBin, args, {
        cwd: projectDir,
        shell: true,
        env: { ...process.env }
    });

    let lineBuf = '';
    let lastWsUrl = '';

    // 🚀 CAÇADOR DE WEBSOCKETS AGRESSIVO
    // Não espera a linha fechar. Caça a URL no exato milissegundo em que ela aparece no fluxo de dados.
    function scanForWebSockets(rawText) {
        // Limpa códigos de cor e caracteres de formatação invisíveis do terminal
        const cleanText = rawText.replace(/\x1B\[[0-9;]*[a-zA-Z]/g, '').replace(/\u001b\[\d+m/g, '');
        
        // Caça o formato exato: ws://IP:PORTA/QUALQUER_COISA/ws
        const wsMatches = cleanText.match(/(ws:\/\/[0-9.]+:[0-9]+\/[^ ]+\/ws)/g);
        
        if (wsMatches) {
            wsMatches.forEach(wsUrl => {
                if (wsUrl !== lastWsUrl) {
                    lastWsUrl = wsUrl;
                    const port = wsUrl.split(':')[2].split('/')[0];
                    console.log(`[FlutterRunner] 🎯 Capturou WebSocket: ${wsUrl}`);
                    onDebugServiceReady({ port, wsUrl });
                }
            });
        }
    }

    function processLine(rawLine) {
        const cleanLine = rawLine.replace(/\x1B\[[0-9;]*[a-zA-Z]/g, '').trim();
        if (!cleanLine) return;

        let level = 'info';
        if (cleanLine.includes('Error:') || cleanLine.includes('Failure') || cleanLine.includes('Exception')) {
            level = 'error';
        } else if (cleanLine.includes('Warning:')) {
            level = 'warn';
        }
        onLog({ level, message: cleanLine, timestamp: Date.now() });
    }

    function streamHandler(chunk) {
        const text = chunk.toString();
        
        // 1. Escaneia o pacote de dados bruto atrás de URLs antes mesmo de quebrar as linhas
        scanForWebSockets(text);

        // 2. Acumula e quebra as linhas para o console normal do painel
        lineBuf += text;
        const lines = lineBuf.split(/\r|\n/);
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