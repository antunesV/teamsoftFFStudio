/**
 * logInjector.js — Inject Dart VM Service instrumentation into Flutter source files
 * V8.1 Definitive Edition - Network Loop Fix
 */

const fs = require('fs');
const path = require('path');

function findFile(rootDir, filename) {
  const results = [];
  function walk(dir) {
    if (!fs.existsSync(dir)) return;
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        if (!['build', '.dart_tool', '.git', '.idea', '.pub-cache', 'dependencies'].includes(entry.name)) walk(full);
      } else if (entry.name === filename) {
        results.push(full);
      }
    }
  }
  walk(rootDir);
  return results;
}

function backup(filePath) {
  const bak = filePath + '.bak';
  if (!fs.existsSync(bak)) fs.copyFileSync(filePath, bak);
  return bak;
}

function safeInjectImport(content, importLine) {
  if (content.includes(importLine)) return content;
  if (content.includes('import ')) return content.replace('import ', `${importLine}\nimport `);
  return importLine + '\n' + content;
}

// 🚀 O ESPIÃO WEB AGORA IGNORA A SI MESMO PARA NÃO DUPLICAR!
function injectWebNetworkSpy(actualRoot) {
  const indexPath = path.join(actualRoot, 'web', 'index.html');
  if (!fs.existsSync(indexPath)) return false;

  let content = fs.readFileSync(indexPath, 'utf8');
  if (content.includes('TS_NETWORK_SPY')) return false;

  const script = `
<script>
(function() {
    const originalFetch = window.fetch;
    window.fetch = async function(...args) {
        let url = ''; let method = 'GET';
        if (typeof args[0] === 'string') url = args[0];
        else if (args[0] && args[0].url) url = args[0].url;
        if (args[1] && args[1].method) method = args[1].method;

        // 🚀 PREVINE O LOOP INFINITO DE DUPLICAÇÃO
        if (url.includes('network-spy') || url.includes('localhost:3000')) return originalFetch.apply(this, args);

        const startTime = Date.now();
        try {
            const response = await originalFetch.apply(this, args);
            const clone = response.clone();
            const duration = Date.now() - startTime;
            
            if (url.includes('supabase') || url.includes('postgrest') || url.includes('/rest/v1/') || url.includes('api')) {
                clone.text().then(body => {
                    let headersObj = {};
                    clone.headers.forEach((value, key) => { headersObj[key] = value; });
                    originalFetch('http://localhost:3000/api/network-spy', {
                        method: 'POST', headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ url: url, method: method, status: clone.status, duration: duration, response: body, headers: JSON.stringify(headersObj), type: (url.includes('supabase') || url.includes('/rest/v1/')) ? 'database' : 'api', ts: Date.now() })
                    }).catch(e => {});
                }).catch(e => {});
            }
            return response;
        } catch(e) { throw e; }
    };

    const XHR = XMLHttpRequest.prototype;
    const open = XHR.open;
    const send = XHR.send;

    XHR.open = function(method, url) {
        this._method = method; this._url = url; this._startTime = Date.now();
        return open.apply(this, arguments);
    };

    XHR.send = function() {
        const url = this._url || '';
        // 🚀 PREVINE O LOOP NO XMLHttp
        if (url.includes('network-spy') || url.includes('localhost:3000')) return send.apply(this, arguments);

        this.addEventListener('load', function() {
            const duration = Date.now() - this._startTime;
            if (url.includes('supabase') || url.includes('postgrest') || url.includes('/rest/v1/') || url.includes('api')) {
                let resBody = 'Non-text response';
                try { if (!this.responseType || this.responseType === 'text' || this.responseType === '') resBody = this.responseText; } catch(e) {}
                try {
                    originalFetch('http://localhost:3000/api/network-spy', {
                        method: 'POST', headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ url: url, method: this._method, status: this.status, duration: duration, response: resBody, headers: this.getAllResponseHeaders(), type: (url.includes('supabase') || url.includes('/rest/v1/')) ? 'database' : 'api', ts: Date.now() })
                    }).catch(e => {});
                } catch(e) {}
            }
        });
        return send.apply(this, arguments);
    };
})();
</script>
`;
  content = content.replace('</head>', `${script}\n</head>`);
  fs.writeFileSync(indexPath, content, 'utf8');
  return true;
}

function ensureActionRegistryExists(rootDir) {
  const registryPath = path.join(rootDir, 'lib', 'flutter_flow', 'action_registry.dart');
  const registryDir = path.dirname(registryPath);
  if (!fs.existsSync(registryDir)) fs.mkdirSync(registryDir, { recursive: true });

  const content = `
import 'dart:developer' as developer;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> globalPageDataRegistry = {};
final Map<String, Map<String, dynamic>> globalActionOutputsRegistry = {};
final List<String> tsPageStack = []; 

class TSSerializer {
  static final Set<int> _visitedObjects = {};

  static dynamic serialize(dynamic value) {
    if (value == null) return null;
    if (value is String || value is num || value is bool) return value;
    final typeStr = value.runtimeType.toString();
    if (typeStr.contains('Controller') || typeStr.contains('Node') || typeStr.contains('Widget') || typeStr.contains('Element') || typeStr.contains('Focus')) return '[Flutter Object: $typeStr]';
    if (!typeStr.contains('Map') && !typeStr.contains('List')) {
        final hash = value.hashCode;
        if (_visitedObjects.contains(hash)) return '[Circular Reference]';
        _visitedObjects.add(hash);
    }
    dynamic result;
    try {
        if (value is DateTime) result = {'type': 'DATE_TIME', 'value': value.toIso8601String()};
        else if (value is Color) result = {'type': 'COLOR', 'value': '#\${value.value.toRadixString(16).padLeft(8, '0')}'};
        else if (value is Iterable) {
           final list = value.take(50).map((e) => serialize(e)).toList();
           if (value.length > 50) list.add('[...truncated, total: \${value.length}]');
           result = list;
        } else if (value is Map) result = value.map((k, v) => MapEntry(k.toString(), serialize(v)));
        else result = value.toString();
    } catch(e) { result = '[Serialization Error]'; }
    if (!typeStr.contains('Map') && !typeStr.contains('List')) _visitedObjects.remove(value.hashCode);
    return result;
  }
}

void updatePageState(String scope, Map<String, dynamic> data) {
  globalPageDataRegistry[scope] = data;
  _notifyStateChange();
}

void updateActionOutput(String scope, String key, dynamic value) {
  if (!globalActionOutputsRegistry.containsKey(scope)) {
    globalActionOutputsRegistry[scope] = {};
  }
  globalActionOutputsRegistry[scope]![key] = TSSerializer.serialize(value);
  _notifyStateChange();
}

void removePageScope(String scope) {
  globalPageDataRegistry.remove(scope);
  globalActionOutputsRegistry.remove(scope);
  _notifyStateChange();
}

Timer? _throttle;
void _notifyStateChange() {
  if (_throttle?.isActive ?? false) return;
  _throttle = Timer(const Duration(milliseconds: 100), () {
     Future.microtask(() {
         try {
           developer.postEvent('teamsoft.state', {
             'type': 'PageStateV2',
             'pageStack': tsPageStack,
             'pagesData': globalPageDataRegistry,
             'actionOutputs': globalActionOutputsRegistry,
             'ts': DateTime.now().millisecondsSinceEpoch,
           });
         } catch (_) {}
     });
  });
}
`;
  fs.writeFileSync(registryPath, content.trim(), 'utf8');
}

function injectAppStateExtension(content, filePath) {
  let result = content.replace(/\s*\/\/ TS_START[\s\S]*?\/\/ TS_END\n?/g, '');
  const actualRoot = filePath.split(path.sep + 'lib' + path.sep)[0];
  
  let authImport = '';
  let authCode = `map['_auth'] = { 'info': 'Authentication not configured' };`;
  const authDir = path.join(actualRoot, 'lib', 'auth');
  
  if (fs.existsSync(authDir)) {
     const authFiles = findFile(authDir, 'auth_util.dart');
     if (authFiles.length > 0) {
         const relPath = authFiles[0].split('lib'+path.sep)[1].replace(/\\/g, '/');
         authImport = `import 'package:${_cachedPackageName}/${relPath}' as auth_utils;`;
         authCode = `
        map['_auth'] = {
          'uid': auth_utils.currentUserUid,
          'email': auth_utils.currentUserEmail,
          'displayName': auth_utils.currentUserDisplayName,
          'loggedIn': auth_utils.currentUserUid.isNotEmpty,
        };`;
     }
  }

  const registryImport = _cachedPackageName
    ? `import 'package:${_cachedPackageName}/flutter_flow/action_registry.dart';`
    : `import 'flutter_flow/action_registry.dart';`;

  result = safeInjectImport(result, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, "import 'dart:convert';");
  result = safeInjectImport(result, registryImport); 
  if (authImport) result = safeInjectImport(result, authImport);

  const classBodyMatch = result.match(/class\s+FFAppState[^\{]*\{([\s\S]+)\}/);
  const classBody = classBodyMatch ? classBodyMatch[1] : '';

  let varsFound = new Set();
  const gettersMatch = [...classBody.matchAll(/\bget\s+([a-zA-Z0-9_]+)\b/g)];
  gettersMatch.forEach(m => varsFound.add(m[1]));
  const fieldsMatch = [...classBody.matchAll(/^\s*(?:late\s+)?(?:final\s+)?(?:[A-Za-z0-9_<>?\[\]]+\s+)([a-zA-Z0-9_]+)\s*(?:=|;)/gm)];
  fieldsMatch.forEach(m => varsFound.add(m[1]));

  const filteredVars = Array.from(varsFound).filter(g => 
    !g.startsWith('_') &&
    !['prefs', 'hashCode', 'runtimeType', 'toJson', 'hasListeners'].includes(g) &&
    !['reset', 'update', 'initializePersistedState', 'notifyListeners', 'addListener', 'removeListener', 'dispose'].includes(g) &&
    !g.includes('library') && !g.includes('enums') && !g.includes('schema')
  );

  const varsCode = filteredVars.map(g => `      try { map['${g}'] = TSSerializer.serialize(this.${g}); } catch(_) {}`).join('\n');

  const injectedCode = `
  // TS_START
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
${varsCode}
    try {
${authCode}
    } catch (e) {
      map['_auth'] = { 'error': 'Auth Not Ready' };
    }
    return map;
  }
  // TS_END
`;

  result = result.replace(/(class\s+FFAppState\s+extends\s+ChangeNotifier\s*\{)/, `$1\n${injectedCode}`);
  return result;
}

function injectMain(content) {
  if (content.includes('// TS_START_MAIN')) return content;
  let result = content;
  result = safeInjectImport(result, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, "import 'dart:convert';");
  result = safeInjectImport(result, "import 'dart:async';");
  result = safeInjectImport(result, "import 'package:flutter/foundation.dart';");
  
  const registryImport = _cachedPackageName
    ? `import 'package:${_cachedPackageName}/flutter_flow/action_registry.dart';`
    : `import 'flutter_flow/action_registry.dart';`;
  result = safeInjectImport(result, registryImport);
  
  const appStateImport = _cachedPackageName
    ? `import 'package:${_cachedPackageName}/app_state.dart';`
    : `import 'app_state.dart';`;
    
  result = safeInjectImport(result, appStateImport);

  const initFunction = `
// TS_START_MAIN
void _initTeamSoftExtensions() {
  developer.registerExtension('ext.teamsoft.ff.version', (m, p) async => developer.ServiceExtensionResponse.result(jsonEncode({'version': '8.1'})));

  try {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      try {
        developer.postEvent('teamsoft.state', {
          'type': 'AppState',
          'variables': FFAppState().toJson(),
          'ts': DateTime.now().millisecondsSinceEpoch,
        });
      } catch (_) {}
    });

    FFAppState().addListener(() {
      try {
        developer.postEvent('teamsoft.state', {
          'type': 'AppState',
          'variables': FFAppState().toJson(),
          'ts': DateTime.now().millisecondsSinceEpoch,
        });
      } catch (_) {}
    });
  } catch (_) {}
}
// TS_END_MAIN
`;
  result += `\n${initFunction}\n`;
  if (result.includes('runApp(')) result = result.replace('runApp(', '_initTeamSoftExtensions();\n  runApp(');
  else result = result.replace(/(void\s+main\([^)]*\)\s*(?:async)?\s*\{)/, `$1\n  _initTeamSoftExtensions();`);
  return result;
}

function injectApiManager(content) {
  if (content.includes("// TS_START_API")) return content;
  let result = safeInjectImport(content, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, "import 'dart:convert';");
  
  result = result.replace(/(Future<ApiCallResponse>\s+(\w+)\s*\([^)]*\)\s*(?:async)?\s*\{)/g, `$1\n    // TS_START_API\n    final _ts_stopwatch = Stopwatch()..start();\n    final String _ts_method_name = '$2';`);
  
  result = result.replace(/return (ApiCallResponse\([^;]+\));/g, (m, args) => `(() { final _r = ${args}; try { developer.postEvent('teamsoft.network', {'duration': _ts_stopwatch.elapsedMilliseconds, 'status': _r.statusCode, 'endpoint': _ts_method_name, 'headers': _r.headers, 'response': _r.bodyText, 'type': 'api', 'ts': DateTime.now().millisecondsSinceEpoch}); } catch(_) {} return _r; })()`);
  
  result = result.replace(/return (ApiCallResponse\.fromHttpResponse\([^;]+\));/g, (m, args) => `(() { final _r = ${args}; try { developer.postEvent('teamsoft.network', {'duration': _ts_stopwatch.elapsedMilliseconds, 'status': _r.statusCode, 'endpoint': 'HTTP', 'headers': _r.headers, 'response': _r.bodyText, 'type': 'api', 'ts': DateTime.now().millisecondsSinceEpoch}); } catch(_) {} return _r; })()`);
  
  return result;
}

function injectSupabaseMonitor(content) {
    if (!content.includes('Supabase') && !content.includes('SupaFlow') && !content.includes('authManager')) return content;
    let res = content;
    res = safeInjectImport(res, "import 'dart:developer' as developer;");

    const regex = /(await\s+[^;]*(?:Supabase|SupaFlow|authManager)[^;]+);/g;
    res = res.replace(regex, (match) => {
        if (match.includes('// TS_DB_SPY')) return match;
        
        let endpointName = 'DB: Query Customizada';
        if (match.includes('authManager.signIn')) endpointName = 'Auth: Login (Sign In)';
        else if (match.includes('authManager.signUp')) endpointName = 'Auth: Cadastro (Sign Up)';
        else if (match.includes('authManager.signOut')) endpointName = 'Auth: Logout';
        else if (match.includes('authManager')) endpointName = 'Auth: Gerenciador';

        return `${match} // TS_DB_SPY\n    try { developer.postEvent('teamsoft.network', {'endpoint': '${endpointName}', 'status': 200, 'duration': 0, 'response': 'Ação interna concluída.', 'type': 'database', 'ts': DateTime.now().millisecondsSinceEpoch}); } catch(_) {}`;
    });
    return res;
}

function injectFlutterFlowModel(content) {
  let result = content.replace(/\/\/\s*TS_START_FFMODEL[\s\S]*?\/\/\s*TS_END_FFMODEL\n?/g, '');
  result = result.replace(/\/\/\s*TS_START_INIT_PUSH[\s\S]*?\/\/\s*TS_END_INIT_PUSH\n?/g, '');

  let lines = result.split(/\r?\n/);
  let finalLines = []; let skippingMode = null; let braceDepth = 0;

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];
    if (skippingMode === 'block') {
      braceDepth += (line.match(/\{/g) || []).length - (line.match(/\}/g) || []).length;
      if (braceDepth <= 0) { skippingMode = null; braceDepth = 0; }
      continue;
    }
    if (skippingMode === 'arrow') {
      if (line.includes(';')) skippingMode = null;
      continue;
    }
    if (/^\s*(?:@override\s+)?(?:void\s+)?\b(onUpdate|updatePage)\b\s*\([^)]*\)\s*(?:=>|\{|$)/.test(line)) {
      if (line.includes('=>')) { if (!line.trim().endsWith(';')) skippingMode = 'arrow'; continue; }
      if (line.includes('{')) {
        braceDepth = (line.match(/\{/g) || []).length - (line.match(/\}/g) || []).length;
        if (braceDepth > 0) skippingMode = 'block';
        continue;
      }
      continue;
    }
    finalLines.push(line);
  }
  result = finalLines.join('\n');

  const registryImport = _cachedPackageName ? `import 'package:${_cachedPackageName}/flutter_flow/action_registry.dart';` : `import '/flutter_flow/action_registry.dart';`;
  result = safeInjectImport(result, "import 'dart:async';");
  result = safeInjectImport(result, registryImport);

  const injection = `
  // TS_START_FFMODEL
  Timer? tsTimer;
  
  void onUpdate() {
    if (updateOnChange) _updateCallback();
    tsBroadcastState();
  }

  void tsBroadcastState() {
    try { updatePageState(this.runtimeType.toString(), ts_toMap()); } catch(_) {}
  }

  Map<String, dynamic> ts_toMap() => {};

  void updatePage(VoidCallback callback) { callback(); onUpdate(); }

  void ts_startPoller() {
     tsTimer?.cancel();
     tsTimer = Timer.periodic(const Duration(milliseconds: 1200), (_) { tsBroadcastState(); });
  }

  void ts_disposePoller() { tsTimer?.cancel(); }
  // TS_END_FFMODEL
`;
  if (result.includes('abstract class FlutterFlowModel')) result = result.replace(/abstract class FlutterFlowModel<[^>]+>\s*\{/, `$& \n${injection}`);
  else result = result.replace(/class\s+FlutterFlowModel<[^>]+>\s*\{/, `$& \n${injection}`);

  if (result.includes('_context = context;')) {
    result = result.replace('_context = context;', `_context = context;\n    // TS_START_INIT_PUSH\n    ts_startPoller();\n    tsBroadcastState();\n    // TS_END_INIT_PUSH`);
  }
  return result;
}

function injectIndividualModel(content, filePath) {
  let result = content.replace(/\s*\/\/ TS_START[\s\S]*?\/\/ TS_END\n/g, '');
  result = result.replace(/\s*\/\/ TS_START_LISTENERS[\s\S]*?\/\/ TS_END_LISTENERS\n/g, '');
  result = result.replace(/\s*try \{ _tsAttachListeners\(\); \} catch\(_\) \{\}\n/g, '');

  const classMatch = result.match(/class\s+([A-Za-z0-9_]+)\s+extends\s+FlutterFlowModel/);
  if (!classMatch) return content;

  const registryImport = _cachedPackageName ? `import 'package:${_cachedPackageName}/flutter_flow/action_registry.dart';` : `import '/flutter_flow/action_registry.dart';`;
  result = safeInjectImport(result, registryImport);

  const lines = result.split('\n');
  let widgetStatesCode = '', pageStatesCode = '';

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (line.includes('class ') || line.includes('void ') || line.includes(' Future<') || line.includes(' get ')) continue;
    const isActionOutput = i > 0 && lines[i - 1].includes('// Stores action output result for');
    const fieldMatch = line.match(/^\s*(?:late\s+)?(?:final\s+)?([A-Z][a-zA-Z0-9_<>,? \[\]]*|dynamic\??|int\??|double\??|bool\??|String\??)\s+([a-zA-Z0-9_]+)(?:\s*=\s*[^;]+)?;/);
    
    if (fieldMatch) {
      const typeStr = fieldMatch[1], fName = fieldMatch[2];
      if (fName.endsWith('_enums') || fName.endsWith('_app_state') || fName.endsWith('_actions') || ['context', 'widget', 'prefs', 'scaffoldKey'].includes(fName) || isActionOutput) continue;
      
      if (typeStr.includes('TextEditingController')) widgetStatesCode += `        try { _widgetState['${fName.replace('TextController', '').replace('Controller', '')}'] = TSSerializer.serialize(${fName}?.text); } catch(_) {}\n`;
      else if (typeStr.includes('FocusNode')) widgetStatesCode += `        try { _widgetState['${fName.replace('FocusNode', '')} Focus'] = TSSerializer.serialize(${fName}?.hasFocus); } catch(_) {}\n`;
      else if (fName.toLowerCase().includes('visibility') || fName.toLowerCase().includes('hover')) widgetStatesCode += `        try { _widgetState['${fName}'] = TSSerializer.serialize(${fName}); } catch(_) {}\n`;
      else pageStatesCode += `        try { _pageState['${fName}'] = TSSerializer.serialize(${fName}); } catch(_) {}\n`;
    }
  }

  const tsToMapCode = `
  // TS_START
  @override
  Map<String, dynamic> ts_toMap() {
    Map<String, dynamic> _widgetState = {}; Map<String, dynamic> _pageState = {};
    try {
${widgetStatesCode}${pageStatesCode}
      return { 'WIDGET STATE': _widgetState, 'PAGE STATE': _pageState };
    } catch(e) { return { 'WIDGET STATE': {}, 'PAGE STATE': {} }; }
  }
  // TS_END
`;
  result = result.replace(new RegExp(`(class\\s+${classMatch[1]}[^{]*{)`), `$1\n${tsToMapCode}`);
  
  if (result.includes('void initState(')) {
    result = result.replace(/(void\s+initState\([^)]*\)\s*\{)/, `$1\n    if (!tsPageStack.contains('${classMatch[1]}')) tsPageStack.add('${classMatch[1]}');\n    ts_startPoller();\n`);
  } else {
    result = result.replace(new RegExp(`(class\\s+${classMatch[1]}[^{]*{)`), `$1\n  @override\n  void initState(BuildContext context) {\n    if (!tsPageStack.contains('${classMatch[1]}')) tsPageStack.add('${classMatch[1]}');\n    ts_startPoller();\n  }\n`);
  }

  if (result.includes('void dispose() {')) {
    result = result.replace('void dispose() {', `void dispose() {\n    tsPageStack.remove('${classMatch[1]}');\n    removePageScope('${classMatch[1]}');\n    ts_disposePoller();\n`);
  } else if (result.includes('void dispose() =>')) {
    result = result.replace(/void dispose\(\)\s*=>\s*([^;]+);/, `void dispose() {\n    $1;\n    tsPageStack.remove('${classMatch[1]}');\n    removePageScope('${classMatch[1]}');\n    ts_disposePoller();\n  }`);
  }

  return result;
}

function injectWidgetActionOutput(content, filePath) {
  let result = content.replace(/\/\/ TS_START_ACTION[\s\S]*?\/\/ TS_END_ACTION\n?/g, '');
  result = result.replace(/^(\s*)try\s*\{\s*updateActionOutput\('[^']+',\s*'[^']+',\s*_model\.[^)]+\);\s*\}\s*catch\(_\)\s*\{\}\n?/gm, '');
  const assignmentRegex = /^\s*(_model\.([a-zA-Z0-9_]*output[a-zA-Z0-9_]*)\s*=\s*(?:await\s+)?[^;]+;)\s*$/gm;
  if (!assignmentRegex.test(result)) return result;
  
  result = safeInjectImport(result, "import '/flutter_flow/action_registry.dart';");
  const widgetClassMatch = result.match(/class\s+(\w+)\s+extends\s+StatefulWidget/);
  const className = widgetClassMatch ? widgetClassMatch[1] : 'UnknownWidget';
  const scopeName = className.endsWith('Widget') ? className.replace('Widget', 'Model') : className + 'Model';
  
  return result.replace(assignmentRegex, (match, p1, p2) => {
      if (match.includes('Uint8List') || match.includes('bytes') || match.includes('file') || match.includes('FFUploadedFile')) return match;
      return `${p1}\n    // TS_START_ACTION\n    try { updateActionOutput('${scopeName}', '${p2}', _model.${p2}); } catch(_) {}\n    // TS_END_ACTION`;
  });
}

let _cachedPackageName = 'resultados_app';

async function inject(projectDir, onStatus) {
  onStatus('🧪 TeamSoft FF Studio V8.1 — Network Loop Fix');
  let actualRoot = projectDir;
  const mainFiles = findFile(projectDir, 'main.dart');
  if (mainFiles.length > 0) {
    const primaryMain = mainFiles.find(f => f.includes(path.sep + 'lib' + path.sep)) || mainFiles[0];
    actualRoot = path.dirname(path.dirname(primaryMain));
  }
  
  injectWebNetworkSpy(actualRoot);
  ensureActionRegistryExists(actualRoot);

  try {
    const pubspec = fs.readFileSync(path.join(actualRoot, 'pubspec.yaml'), 'utf8');
    const nameMatch = pubspec.match(/^name:\s*([a-zA-Z0-9_]+)/m);
    if (nameMatch) _cachedPackageName = nameMatch[1];
  } catch (e) {}

  const processFiles = (pattern, injector, label) => {
    const files = pattern.includes('*') ? [] : findFile(actualRoot, pattern);
    if (pattern.includes('*')) {
      const search = (dir) => {
        if (!fs.existsSync(dir)) return;
        fs.readdirSync(dir).forEach(f => {
          const p = path.join(dir, f);
          if (fs.statSync(p).isDirectory()) { if (!['build', '.dart_tool'].includes(f)) search(p); }
          else if (f.endsWith(pattern.replace('*', ''))) files.push(p);
        });
      };
      search(path.join(actualRoot, 'lib'));
    }
    let count = 0;
   for (const f of files) {
      if (f.includes('flutter_flow_model.dart') && injector !== injectFlutterFlowModel) continue;
      const original = fs.readFileSync(f, 'utf8');
      const modified = injector(original, f);
      if (modified !== original) { backup(f); fs.writeFileSync(f, modified, 'utf8'); count++; }
    }
  };

  processFiles('app_state.dart', injectAppStateExtension, 'AppState tracking');
  processFiles('main.dart', injectMain, 'Main initialization');
  processFiles('flutter_flow_model.dart', injectFlutterFlowModel, 'FFModel base');
  processFiles('*_model.dart', injectIndividualModel, 'Individual models');
  processFiles('*_widget.dart', injectWidgetActionOutput, 'Widget actions');
  
  onStatus('✅ instrumentation complete.');
}

module.exports = { inject, findFile, injectFlutterFlowModel };