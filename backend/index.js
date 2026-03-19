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
const telemetry = require('./services/telemetry');

let localEnvApiKey = '';
try {
  const envPath = path.join(__dirname, '.env');
  if (fs.existsSync(envPath)) {
    const envData = fs.readFileSync(envPath, 'utf8');
    const match = envData.match(/SANDIN_API_KEY=(.*)/);
    if (match) localEnvApiKey = match[1].trim().replace(/['"]/g, '');
  }
} catch (e) {}

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: '*', methods: ['GET', 'POST'] } });

app.use(cors());
app.use(express.json({ limit: '50mb' }));

let currentProcess = null;
let sandinApiKey = '';
let activeProjectPath = null; 

let savedCommands = []; 
let logHistory = []; 
let networkHistory = [];

const lastState = {
  "APPLICATION STATE": {}, "AUTHENTICATION": {}, "WIDGET STATE": {}, "PAGE STATE": {}, "ACTION OUTPUTS": {}, "active_page": "Inicialização do App"
};

// Prevent UI flicker while still allowing legitimate empty states.
const EMPTY_GRACE_MS = 800;
const PAGE_CHANGE_GRACE_MS = 250;
const lastNonEmptyTs = { widget: 0, page: 0, actions: 0 };
let lastActivePage = lastState['active_page'];

const CONFIG_PATH = path.join(require('os').homedir(), '.teamsoft-ff-localrun', 'config.json');

function loadPersistedConfig() {
  try {
    if (fs.existsSync(CONFIG_PATH)) {
      const cfg = JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8'));
      if (cfg.sandinApiKey) sandinApiKey = cfg.sandinApiKey;
      if (cfg.savedCommands) savedCommands = cfg.savedCommands;
    }
  } catch (e) {}
}

function persistConfig(newConfig) {
  try {
    const dir = path.dirname(CONFIG_PATH);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    const existing = fs.existsSync(CONFIG_PATH) ? JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8')) : {};
    fs.writeFileSync(CONFIG_PATH, JSON.stringify({ ...existing, ...newConfig }, null, 2));
  } catch (e) {}
}

function saveCommandToHistory(cmd) {
  savedCommands = savedCommands.filter(c => c !== cmd);
  savedCommands.unshift(cmd);
  if (savedCommands.length > 5) savedCommands.pop();
  persistConfig({ savedCommands });
}

loadPersistedConfig();

io.on('connection', (socket) => {
  socket.on('request-initial-state', async () => {
    socket.emit('log-history', logHistory);
    networkHistory.forEach(n => socket.emit('network-update', n));
    
    if (global.vmClient && global.vmClient.isolateId) {
      try {
        const res = await global.vmClient.callServiceExtension('ext.teamsoft.ff.getState', {}).catch(() => null);
        if (res && res.valueAsString) updateLastState(JSON.parse(res.valueAsString));
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

app.post('/api/network-spy', (req, res) => {
  const data = req.body;
  let endpoint = data.url;
  try {
      const urlObj = new URL(data.url);
      endpoint = urlObj.pathname.split('/').pop() || urlObj.pathname;
      if (urlObj.searchParams.has('select')) endpoint += `?select=${urlObj.searchParams.get('select')}`;
  } catch(e) {}

  // 🚀 ASSINANDO A PÁGINA ATUAL NA REQUISIÇÃO
  const netData = {
      endpoint: `${data.method} /${endpoint}`,
      status: data.status,
      duration: data.duration,
      response: data.response,
      headers: data.headers,
      type: data.type,
      ts: data.ts,
      page: lastState['active_page'] || 'Global Inicialização'
  };
  
  networkHistory.unshift(netData);
  if (networkHistory.length > 100) networkHistory.pop();
  io.emit('network-update', netData);
  res.sendStatus(200);
});

function updateLastState(data) {
  if (!data) return;

  if (data.type === 'AppState') {
      const vars = data.variables || {};
      if (vars._auth) {
          lastState['AUTHENTICATION'] = vars._auth;
          delete vars._auth;
      }
      lastState['APPLICATION STATE'] = vars;
  } else if (data.type === 'MergedPageState') {
      lastState['WIDGET STATE'] = data['WIDGET STATE'] || {};
      lastState['PAGE STATE'] = data['PAGE STATE'] || {};
      lastState['ACTION OUTPUTS'] = data['ACTION OUTPUTS'] || {};
      lastState['active_page'] = data['active_page'] || 'Unknown';
  } else if (data.type === 'PageStateV2') {
      const pageStack = data.pageStack || [];
      const pagesData = data.pagesData || {};
      const actionOutputs = data.actionOutputs || {};

      let activePage = pageStack.length > 0 ? pageStack[pageStack.length - 1] : 'Unknown';
      let combinedWidget = {};
      let combinedPage = {};

      if (activePage.includes('BottomSheet') || activePage.includes('Dialog') || activePage.includes('Component')) {
          const parentPage = pageStack.length > 1 ? pageStack[pageStack.length - 2] : null;
          if (parentPage && pagesData[parentPage]) {
              Object.assign(combinedWidget, pagesData[parentPage]['WIDGET STATE'] || {});
              Object.assign(combinedPage, pagesData[parentPage]['PAGE STATE'] || {});
          }
      }

      if (pagesData[activePage]) {
          Object.assign(combinedWidget, pagesData[activePage]['WIDGET STATE'] || {});
          Object.assign(combinedPage, pagesData[activePage]['PAGE STATE'] || {});
      }

      let flatActions = {};
      for (const scope in actionOutputs) {
          Object.assign(flatActions, actionOutputs[scope]);
      }

      const now = Date.now();
      const pageChanged = activePage !== lastActivePage;
      lastActivePage = activePage;
      lastState['active_page'] = activePage;

      const applyWithGrace = (key, nextObj, prevObj, bucket) => {
        const nextHas = Object.keys(nextObj).length > 0;
        const prevHas = Object.keys(prevObj).length > 0;

        if (nextHas) {
          lastNonEmptyTs[bucket] = now;
          lastState[key] = nextObj;
          return;
        }

        // Legit empty: allow it after grace period.
        // When a page changes, we allow empty faster (transition-friendly).
        const grace = pageChanged ? PAGE_CHANGE_GRACE_MS : EMPTY_GRACE_MS;
        const sinceNonEmpty = lastNonEmptyTs[bucket] ? (now - lastNonEmptyTs[bucket]) : Number.POSITIVE_INFINITY;

        if (!prevHas) {
          // Already empty: keep empty.
          lastState[key] = nextObj;
          return;
        }

        if (sinceNonEmpty >= grace) {
          lastState[key] = nextObj; // clear to empty after grace
        }
        // else keep previous non-empty snapshot briefly to prevent flicker
      };

      applyWithGrace('WIDGET STATE', combinedWidget, lastState['WIDGET STATE'] || {}, 'widget');
      applyWithGrace('PAGE STATE', combinedPage, lastState['PAGE STATE'] || {}, 'page');
      applyWithGrace('ACTION OUTPUTS', flatActions, lastState['ACTION OUTPUTS'] || {}, 'actions');
  }

  io.emit('state-snapshot', { ...lastState, ts: Date.now(), isolateId: global.vmClient ? global.vmClient.isolateId : null });
}

function emit(event, data) {
  if (event === 'state-update') {
    updateLastState(data);
  } else {
    io.emit(event, data);
  }
}

function appendLog(entry) {
  const msg = typeof entry === 'object' ? entry.message : entry;
  const lvl = typeof entry === 'object' && entry.level ? entry.level.toUpperCase() : 'INFO';
  const logStr = `[${lvl}] ${msg}`;
  
  console.log(logStr);
  logHistory.push(logStr);
  if (logHistory.length > 300) logHistory.shift();
  emit('log', logStr);
}

// ─── ROTAS DE ARQUIVOS E PROJETO ─────────────────────────────────────────────

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

app.get('/api/pages-tree', (req, res) => {
  const projectsDir = path.join(require('os').homedir(), '.teamsoft-ff-localrun', 'projects');
  let targetPath = activeProjectPath;

  if (!targetPath && fs.existsSync(projectsDir)) {
    const folders = fs.readdirSync(projectsDir).map(f => path.join(projectsDir, f)).filter(f => fs.statSync(f).isDirectory()).sort((a, b) => fs.statSync(b).mtime.getTime() - fs.statSync(a).mtime.getTime());
    if (folders.length > 0) targetPath = folders[0];
  }
  if (!targetPath) return res.json({ pages: [], components: [] });

  const pages = [];
  const components = [];
  const libPath = path.join(targetPath, 'lib');
  
  const scan = (dir) => {
    if (!fs.existsSync(dir)) return;
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        if (!['build', '.dart_tool', 'custom_code', 'flutter_flow'].includes(entry.name)) scan(fullPath);
      } else if (entry.name.endsWith('_widget.dart')) {
        const content = fs.readFileSync(fullPath, 'utf8');
        const classMatch = content.match(/class\s+([A-Z]\w+)Widget\s+extends/);
        if (!classMatch) continue;
        
        const routeName = classMatch[1];
        const isComponent = fullPath.includes(path.sep + 'components' + path.sep) || fullPath.includes(path.sep + 'shared' + path.sep) || routeName.includes('BottomSheet') || routeName.includes('Component');
        const tree = [];
        let inBuild = false;
        const lines = content.split('\n');
        
        for (let line of lines) {
          if (line.includes('Widget build(BuildContext context)')) {
            inBuild = true; continue;
          }
          if (inBuild) {
            if (line.match(/^  \}/) || line.match(/^\}/)) break; 
            const wMatch = line.match(/^(\s*)(?:(?:[a-zA-Z_]\w*\s*:\s*(?:\[\s*)?)|(?:return\s+))?(?:const\s+)?([A-Z]\w+)\s*\(/);
            if (wMatch) {
              const depth = Math.floor(wMatch[1].length / 2);
              const wName = wMatch[2];
              const ignoreList = ['EdgeInsets', 'BorderRadius', 'BoxDecoration', 'TextStyle', 'Color', 'Size', 'Offset', 'Duration', 'AlignmentDirectional', 'Alignment', 'ThemeData', 'Padding', 'SafeArea', 'GestureDetector'];
              if (!ignoreList.includes(wName)) tree.push({ name: wName, depth: depth });
            }
          }
        }
        if (isComponent) components.push({ route: routeName, file: entry.name, tree: tree });
        else pages.push({ route: routeName, file: entry.name, tree: tree });
      }
    }
  };
  try { scan(libPath); res.json({ pages, components }); } catch(e) { res.status(500).json({ error: e.message }); }
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
      prompt: `Faça um Code Review deste código Flutter/Dart:\n\n\`\`\`dart\n${code}\n\`\`\``,
      apiKey: sandinApiKey, 
      onChunk: (chunk) => { result += chunk; }
    });
    res.json({ analysis: result });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.post('/api/chat', async (req, res) => {
  const { message, errorLog } = req.body;
  let fileContent = '';
  let filePath = '';

  if (errorLog) {
     const match = errorLog.match(/file:\/\/\/([^\s"']+)/);
     if (match) {
        filePath = decodeURI(match[1]);
        if (process.platform === 'win32' && filePath.startsWith('/')) filePath = filePath.substring(1);
        if (fs.existsSync(filePath)) fileContent = fs.readFileSync(filePath, 'utf8');
     }
  }

  const promptText = message ? message : `O console do Flutter disparou este erro:\n\n\`\`\`text\n${errorLog}\n\`\`\`\nDiga qual é a causa raiz e como consertar. Seja direto.`;
  const context = fileContent ? `\n\nEu fui até o projeto e trouxe o código do arquivo afetado (${path.basename(filePath)}):\n\`\`\`dart\n${fileContent}\n\`\`\`\n` : '';

  const apiKey = localEnvApiKey || sandinApiKey || 'AIzaSy...';
  
// Atualizado para usar o Gemini 2.5 Flash
const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`;

  try {
    const response = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            systemInstruction: { parts: [{ text: "Você é o Sandin AI, um Engenheiro Sênior em Flutter/FlutterFlow e meu Copilot. Responda em português, seja prestativo, mostre código quando necessário e use formatação Markdown." }] },
            contents: [{ role: "user", parts: [{ text: promptText + context }] }]
        })
    });

    const data = await response.json();
    if (!response.ok) throw new Error(data.error?.message || 'Erro na API do Gemini');
    res.json({ analysis: data.candidates[0].content.parts[0].text });
  } catch (e) { res.json({ analysis: `⚠️ **Falha na Conexão com a IA:**\n\n${e.message}` }); }
});

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

function askForCommand() {
  if (savedCommands.length > 0) {
    console.log('\n🌟 Projetos Recentes (Atalhos):');
    savedCommands.forEach((cmd, idx) => {
      const match = cmd.match(/--project\s+([^\s]+)/);
      console.log(`  [${idx + 1}] ${match ? match[1] : `Comando ${idx + 1}`}`);
    });
    console.log(`  [0] 🗑️  Limpar histórico`);
  }

  rl.question(savedCommands.length > 0 ? '\n▶ Digite o NÚMERO ou cole o comando FF: ' : '\n▶ Cole o comando FF: ', async (input) => {
    const trimmed = input.trim();
    if (!trimmed) return askForCommand();

    if (trimmed === '0' && savedCommands.length > 0) {
      savedCommands = [];
      persistConfig({ savedCommands: [] });
      console.log('🧹 Histórico limpo!');
      return askForCommand();
    }

    const num = parseInt(trimmed, 10);
    if (!isNaN(num) && num > 0 && num <= savedCommands.length && !trimmed.startsWith('flutterflow')) {
      const selectedCmd = savedCommands[num - 1];
      console.log(`\n🚀 Executando atalho [${num}]...`);
      saveCommandToHistory(selectedCmd);
      await orchestrate(selectedCmd);
      return;
    }

    if (trimmed.includes('flutterflow export-code')) {
      saveCommandToHistory(trimmed);
      await orchestrate(trimmed);
    } else {
      console.log('⚠️ Comando inválido.');
      askForCommand();
    }
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
        if (global.vmClient) {
            console.log(`[Main] 🔄 Trocando conexão VM Service: ${wsUrl}`);
            global.vmClient.close();
        }

        emit('debug-service-ready', { port, wsUrl });
        const telemetryRouter = new TelemetryRouter((event, data) => emit(event, data), (msg) => appendLog(msg), telemetry);
        
        global.vmClient = new VmServiceClient(
          wsUrl,
          (streamId, event) => {
             if (streamId === 'Extension' && event.extensionKind === 'teamsoft.state') {
                 try { emit('state-update', event.extensionData); } catch (e) {}
             }
             telemetryRouter.routeEvent(streamId, event);
          },
          () => appendLog({ level: 'warn', message: '⚠️ VM Disconnected', timestamp: Date.now() }),
          (msg) => appendLog(msg),
          (id) => emit('vm-isolate-changed', { isolateId: id })
        );

        if (!global.dashboardLaunched) {
            global.dashboardLaunched = true;
            launchDashboard();
        }
      },
      onExit: (code) => { 
          currentProcess = null; 
          global.dashboardLaunched = false;
          askForCommand(); 
      }
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