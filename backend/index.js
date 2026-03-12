/**
 * TeamSoft FF LocalRun — Backend Entry Point
 * Port 3000: WebSocket/Telemetry Router + REST API
 */

const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const cors = require('cors');
const path = require('path');
const fs = require('fs');
const readline = require('readline');
const { spawn, execSync } = require('child_process');

const envManager = require('./services/envManager');
const projectExporter = require('./services/projectExporter');
const flutterRunner = require('./services/flutterRunner');
const logInjector = require('./services/logInjector');
const sandinAI = require('./services/sandinAI');
const VmServiceClient = require('./services/vmServiceClient');
const TelemetryRouter = require('./services/telemetryRouter');
const panelBuilder = require('./services/panelBuilder');
const telemetry = require('./services/telemetry');

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: '*', methods: ['GET', 'POST'] } });

app.use(cors());
app.use(express.json());

let currentProcess = null;
let sandinApiKey = '';
let activeProjectPath = null; 

const lastState = {
  "APPLICATION STATE": {}, "AUTHENTICATION": {}, "WIDGET STATE": {}, "PAGE STATE": {}, "ACTION OUTPUTS": {}, "active_page": "Unknown"
};

const CONFIG_PATH = path.join(require('os').homedir(), '.teamsoft-ff-localrun', 'config.json');

function loadPersistedConfig() {
  try {
    if (fs.existsSync(CONFIG_PATH)) {
      const cfg = JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8'));
      if (cfg.sandinApiKey) sandinApiKey = cfg.sandinApiKey;
    }
  } catch (e) {}
}
loadPersistedConfig();

io.on('connection', (socket) => {
  socket.on('request-initial-state', async () => {
    if (global.vmClient && global.vmClient.isolateId) {
      try {
        const res = await global.vmClient.callServiceExtension('ext.teamsoft.ff.getState', {}).catch(() => null);
        if (res && res.valueAsString) updateLastState(JSON.parse(res.valueAsString));
        const resPage = await global.vmClient.callServiceExtension('ext.teamsoft.page_inspector', {}).catch(() => null);
        if (resPage && resPage.valueAsString) updateLastState({ type: 'PageState', ...JSON.parse(resPage.valueAsString) });
      } catch (e) { }
    }
    socket.emit('state-snapshot', { ...lastState, ts: Date.now(), isolateId: global.vmClient ? global.vmClient.isolateId : 'disconnected' });
  });

  socket.on('telemetry-batch', (batch) => {
    if (batch && Array.isArray(batch.events)) {
      batch.events.forEach(ev => {
        telemetry.record(ev.type, ev.data);
        io.emit('ff-log', { events: [ev] });
      });
    }
  });
});

function updateLastState(data) {
  if (!data) return;
  if (data.type === 'AppState' || data.variables) {
    const type = data.type || 'AppState';
    const vars = data.variables || data;
    if (type === 'AppState') {
      if (vars && vars._auth) { lastState['AUTHENTICATION'] = vars._auth; delete vars._auth; }
      lastState['APPLICATION STATE'] = vars;
    } else if (type === 'PageState') {
      if (vars['WIDGET STATE'] || vars['PAGE STATE'] || vars['ACTION OUTPUTS']) {
        if (vars['WIDGET STATE']) lastState['WIDGET STATE'] = vars['WIDGET STATE'];
        if (vars['PAGE STATE']) lastState['PAGE STATE'] = vars['PAGE STATE'];
        if (vars['ACTION OUTPUTS']) lastState['ACTION OUTPUTS'] = { ...lastState['ACTION OUTPUTS'], ...vars['ACTION OUTPUTS'] };
        if (vars['_ts_updated']) { lastState['PAGE STATE'] = lastState['PAGE STATE'] || {}; lastState['PAGE STATE']['_ts_updated'] = vars['_ts_updated']; }
      } else {
        lastState['ACTION OUTPUTS'] = { ...lastState['ACTION OUTPUTS'], ...vars };
        delete lastState['ACTION OUTPUTS']['_ts_updated'];
      }
      if (data.page) lastState['active_page'] = data.page;
    } else {
      lastState[type] = vars;
    }
  }
}

function emit(event, data) {
  if (event === 'state-update') {
    updateLastState(data);
    io.emit('state-snapshot', { ...lastState, ts: Date.now(), isolateId: global.vmClient ? global.vmClient.isolateId : null });
  } else {
    io.emit(event, data);
  }
}

function appendLog(entry) {
  console.log(`[${entry.level ? entry.level.toUpperCase() : 'INFO'}] ${entry.message}`);
  emit('log', entry);
}

// ─── ROTAS DE CÓDIGO E IA ─────────────────────────────────────────────

app.get('/api/custom-code', (req, res) => {
  const projectsDir = path.join(require('os').homedir(), '.teamsoft-ff-localrun', 'projects');
  let targetPath = activeProjectPath;

  if (!targetPath && fs.existsSync(projectsDir)) {
    const folders = fs.readdirSync(projectsDir).map(f => path.join(projectsDir, f)).filter(f => fs.statSync(f).isDirectory()).sort((a, b) => fs.statSync(b).mtime.getTime() - fs.statSync(a).mtime.getTime());
    if (folders.length > 0) targetPath = folders[0];
  }
  if (!targetPath) return res.json({ files: [] });

  let customCodeDir = null;
  const findCustomCode = (dir, depth = 0) => {
    if (depth > 3 || !fs.existsSync(dir)) return;
    const checkPath = path.join(dir, 'lib', 'custom_code');
    if (fs.existsSync(checkPath)) { customCodeDir = checkPath; return; }
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      if (entry.isDirectory() && !['.git', 'build', '.dart_tool'].includes(entry.name)) {
        findCustomCode(path.join(dir, entry.name), depth + 1);
        if (customCodeDir) return; 
      }
    }
  };
  findCustomCode(targetPath);
  if (!customCodeDir) return res.json({ files: [] });

  const files = [];
  const scan = (dir) => {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) scan(fullPath);
      else if (entry.name.endsWith('.dart') && !entry.name.startsWith('.')) {
        files.push({ name: entry.name, path: fullPath, category: path.basename(dir), content: fs.readFileSync(fullPath, 'utf8') });
      }
    }
  };
  try { scan(customCodeDir); res.json({ files }); } catch(e) { res.status(500).json({ error: e.message }); }
});

app.post('/api/open-editor', (req, res) => {
  const { filePath, editor } = req.body;
  if (!filePath || !fs.existsSync(filePath)) return res.status(400).json({ error: 'File not found' });
  const localAppData = process.env.LOCALAPPDATA || path.join(require('os').homedir(), 'AppData', 'Local');
  const programFiles = process.env.PROGRAMFILES || 'C:\\Program Files';
  let cmd = `code "${filePath}"`;

  if (editor === 'vscode') {
    const vsCodeUserPath = path.join(localAppData, 'Programs', 'Microsoft VS Code', 'Code.exe');
    const vsCodeSystemPath = path.join(programFiles, 'Microsoft VS Code', 'Code.exe');
    if (process.platform === 'win32') {
      if (fs.existsSync(vsCodeUserPath)) cmd = `"${vsCodeUserPath}" "${filePath}"`;
      else if (fs.existsSync(vsCodeSystemPath)) cmd = `"${vsCodeSystemPath}" "${filePath}"`;
    }
  } else if (editor === 'cursor') {
    const cursorWinPath = path.join(localAppData, 'Programs', 'cursor', 'Cursor.exe');
    if (process.platform === 'win32' && fs.existsSync(cursorWinPath)) cmd = `"${cursorWinPath}" "${filePath}"`;
    else cmd = `cursor "${filePath}"`;
  }
  require('child_process').exec(cmd, (err) => { res.json({ success: true }); });
});

app.post('/api/analyze-code', async (req, res) => {
  const { code } = req.body;
  if (!code) return res.status(400).json({ error: 'Código vazio' });
  
  try {
    let result = '';
    await sandinAI.analyze({
      prompt: `Atue como um Engenheiro de Software Sênior especialista em Flutter e FlutterFlow. 
Faça um Code Review rápido e direto do código abaixo. 
Foque apenas nestes 3 pontos:
1. Bugs ou riscos de NullPointerException.
2. Gargalos de Performance.
3. Melhorias de Clean Code.
Mantenha a resposta técnica, em português e use Markdown para formatar.

Código:
\`\`\`dart
${code}
\`\`\``,
      apiKey: sandinApiKey, 
      onChunk: (chunk) => { result += chunk; }
    });
    
    if (!result) result = "⚠️ **IA não configurada.**\n\nPara ativar o Code Review Automático, defina sua API Key (OpenAI/Anthropic/Gemini) no arquivo de configuração.";
    res.json({ analysis: result });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// ─── ORQUESTRAÇÃO ─────────────────────────────────────────────
const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

function askForCommand() {
  rl.question('\n▶ Cole o comando do FlutterFlow: ', async (command) => {
    if (!command.trim()) return askForCommand();
    await orchestrate(command.trim());
  });
}

async function orchestrate(command) {
  try {
    if (currentProcess) { currentProcess.kill(); currentProcess = null; }
    appendLog({ level: 'info', message: '📦 Exporting project...', timestamp: Date.now() });
    
    const resolvedPath = await projectExporter.exportProject(command, (msg) => appendLog({ level: 'info', message: msg, timestamp: Date.now() }), true);
    activeProjectPath = resolvedPath;

    if (!resolvedPath) return askForCommand();
    await logInjector.inject(resolvedPath, (msg) => appendLog({ level: 'info', message: `[LogInjector] ${msg}`, timestamp: Date.now() }));

    const flutterBin = envManager.resolveFlutterBin();
    execSync(`"${flutterBin}" pub get`, { cwd: resolvedPath, stdio: 'inherit' });

    currentProcess = flutterRunner.run(resolvedPath, {
      onLog: (entry) => appendLog(entry),
      onDebugServiceReady: async ({ port, wsUrl }) => {
        emit('debug-service-ready', { port, wsUrl });
        const telemetryRouter = new TelemetryRouter((event, data) => emit(event, data), (msg) => appendLog(msg), telemetry);
        global.vmClient = new VmServiceClient(
          wsUrl,
          (streamId, event) => {
             if (streamId === 'Extension' && event.extensionKind === 'teamsoft.state') {
                 try { emit('state-update', typeof event.extensionData.data === 'string' ? JSON.parse(event.extensionData.data) : event.extensionData.data); } catch (e) {}
             }
             telemetryRouter.routeEvent(streamId, event);
          },
          () => appendLog({ level: 'warn', message: '⚠️ VM Disconnected', timestamp: Date.now() }),
          (msg) => appendLog(msg),
          (id) => emit('vm-isolate-changed', { isolateId: id })
        );
        launchDashboard();
      },
      onExit: (code) => { currentProcess = null; askForCommand(); }
    });
  } catch (err) { askForCommand(); }
}

function launchDashboard() {
  const dashboardPath = path.join(__dirname, '..', 'frontend_flutter', 'frontend_flutter');
  const flutterBin = envManager.resolveFlutterBin();
  spawn(flutterBin, ['run', '-d', 'chrome', '--web-port', '8080'], { cwd: dashboardPath, stdio: 'inherit', shell: true, env: process.env });
}

async function bootstrap() {
  console.clear();
  console.log(`\n╔══════════════════════════════════════════╗`);
  console.log(`║      TeamSoft FF Studio — CLI Daemon     ║`);
  console.log(`╚══════════════════════════════════════════╝\n`);
  await envManager.ensureAll(msg => console.log(`[env] ${msg}`));
  server.listen(3000, () => askForCommand());
}
bootstrap();