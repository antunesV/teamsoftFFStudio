/**
 * logInjector.js — Inject Dart VM Service instrumentation into Flutter source files
 * V5.2 Action Output Isolation + Bulletproof AppState
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
  if (content.includes('import ')) {
    return content.replace('import ', `${importLine}\nimport `);
  }
  return importLine + '\n' + content;
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
// V5.2 Cofre isolado apenas para Action Outputs (Evita duplicação)
final Map<String, Map<String, dynamic>> globalActionOutputsRegistry = {}; 
String? activePageName;

class TSSerializer {
  static final Set<int> _visitedObjects = {};

  static dynamic serialize(dynamic value) {
    if (value == null) return null;
    if (value is String || value is num || value is bool) return value;
    
    final typeStr = value.runtimeType.toString();
    if (typeStr.contains('Controller') || typeStr.contains('Node') || typeStr.contains('Widget') || typeStr.contains('Element') || typeStr.contains('Focus')) {
      return '[Flutter Object: $typeStr]';
    }

    if (!typeStr.contains('Map') && !typeStr.contains('List')) {
        final hash = value.hashCode;
        if (_visitedObjects.contains(hash)) return '[Circular Reference]';
        _visitedObjects.add(hash);
    }

    dynamic result;
    try {
        if (value is DateTime) {
           result = {'type': 'DATE_TIME', 'value': value.toIso8601String()};
        } else if (value is Color) {
           result = {'type': 'COLOR', 'value': '#\${value.value.toRadixString(16).padLeft(8, '0')}'};
        } else if (value is Iterable) {
           final list = value.take(50).map((e) => serialize(e)).toList();
           if (value.length > 50) list.add('[...truncated, total: \${value.length}]');
           result = list;
        } else if (value is Map) {
           result = value.map((k, v) => MapEntry(k.toString(), serialize(v)));
        } else {
           result = value.toString();
        }
    } catch(e) {
        result = '[Serialization Error]';
    }
    
    if (!typeStr.contains('Map') && !typeStr.contains('List')) {
       _visitedObjects.remove(value.hashCode);
    }
    return result;
  }
}

void updateActionOutput(String scope, String key, dynamic value) {
  if (!globalActionOutputsRegistry.containsKey(scope)) {
    globalActionOutputsRegistry[scope] = {};
  }
  globalActionOutputsRegistry[scope]![key] = TSSerializer.serialize(value);
  _notifyStateChange(scope);
}

void updatePageState(String scope, Map<String, dynamic> data) {
  globalPageDataRegistry[scope] = data;
  _notifyStateChange(scope);
}

Timer? _throttle;
void _notifyStateChange(String scope) {
  if (_throttle?.isActive ?? false) return;
  
  _throttle = Timer(const Duration(milliseconds: 200), () {
     Future.microtask(() {
         try {
           developer.postEvent('teamsoft.state', {
             'type': 'PageState',
             'page': scope,
             'variables': globalPageDataRegistry[scope] ?? {},
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

  result = safeInjectImport(result, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, "import 'dart:convert';");
  result = safeInjectImport(result, "import '/flutter_flow/action_registry.dart';"); 
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
  result = safeInjectImport(result, "import '/flutter_flow/action_registry.dart';");
  
  const appStateImport = _cachedPackageName
    ? `import 'package:${_cachedPackageName}/app_state.dart';`
    : `import '/app_state.dart';`;
    
  result = safeInjectImport(result, appStateImport);

  const initFunction = `
// TS_START_MAIN
void _initTeamSoftExtensions() {
  developer.registerExtension('ext.teamsoft.ff.version', (m, p) async => developer.ServiceExtensionResponse.result(jsonEncode({'version': '5.2'})));
  
  developer.registerExtension('ext.teamsoft.page_inspector', (method, params) async {
    final page = params['page'] ?? activePageName;
    return developer.ServiceExtensionResponse.result(jsonEncode({
      'page': page,
      'variables': page != null ? globalPageDataRegistry[page] : globalPageDataRegistry,
      'all_pages': globalPageDataRegistry.keys.toList(),
      'ts': DateTime.now().millisecondsSinceEpoch,
    }));
  });

  try {
    Timer.periodic(const Duration(seconds: 2), (timer) {
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
  result = result.replace(/(Future<ApiCallResponse>\s+(\w+)\s*\([^)]*\)\s*(?:async)?\s*\{)/g, `$1\n    // TS_START_API\n    final _ts_stopwatch = Stopwatch()..start();\n    final String _ts_method_name = '$2';`);
  result = result.replace(/return (ApiCallResponse\([^;]+\));/g, (m, args) => `(() { final _r = ${args}; try { developer.postEvent('teamsoft.network', {'duration': _ts_stopwatch.elapsedMilliseconds, 'status': _r.statusCode, 'endpoint': _ts_method_name, 'type': 'api_call', 'ts': DateTime.now().millisecondsSinceEpoch}); } catch(_) {} return _r; })()`);
  result = result.replace(/return (ApiCallResponse\.fromHttpResponse\([^;]+\));/g, (m, args) => `(() { final _r = ${args}; try { developer.postEvent('teamsoft.network', {'duration': _ts_stopwatch.elapsedMilliseconds, 'status': _r.statusCode, 'endpoint': 'HTTP', 'type': 'http_call', 'ts': DateTime.now().millisecondsSinceEpoch}); } catch(_) {} return _r; })()`);
  return result;
}

function injectFlutterFlowModel(content) {
  let result = content;

  result = result.replace(/\/\/\s*TS_START_FFMODEL[\s\S]*?\/\/\s*TS_END_FFMODEL\n?/g, '');
  result = result.replace(/\/\/\s*TS_START_INIT_PUSH[\s\S]*?\/\/\s*TS_END_INIT_PUSH\n?/g, '');

  let lines = result.split(/\r?\n/);
  let finalLines = [];
  let skippingMode = null;
  let braceDepth = 0;

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];
    if (skippingMode === 'block') {
      const open = (line.match(/\{/g) || []).length;
      const close = (line.match(/\}/g) || []).length;
      braceDepth += open - close;
      if (braceDepth <= 0) { skippingMode = null; braceDepth = 0; }
      continue;
    }
    if (skippingMode === 'arrow') {
      if (line.includes(';')) skippingMode = null;
      continue;
    }
    const isDecl = /^\s*(?:@override\s+)?(?:void\s+)?\b(onUpdate|updatePage)\b\s*\([^)]*\)\s*(?:=>|\{|$)/.test(line);
    if (isDecl) {
      if (line.includes('=>')) { if (!line.trim().endsWith(';')) skippingMode = 'arrow'; continue; }
      if (line.includes('{')) {
        const open = (line.match(/\{/g) || []).length;
        const close = (line.match(/\}/g) || []).length;
        braceDepth = open - close;
        if (braceDepth > 0) skippingMode = 'block';
        continue;
      }
      continue;
    }
    finalLines.push(line);
  }
  result = finalLines.join('\n');

  const registryImport = _cachedPackageName
    ? `import 'package:${_cachedPackageName}/flutter_flow/action_registry.dart';`
    : `import '/flutter_flow/action_registry.dart';`;

  result = safeInjectImport(result, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, registryImport);

  const injection = `
  // TS_START_FFMODEL
  void onUpdate() {
    if (updateOnChange) _updateCallback();
    try {
      final stateName = this.runtimeType.toString();
      final vars = ts_toMap();
      updatePageState(stateName, vars);
    } catch(_) {}
  }

  Map<String, dynamic> ts_toMap() => {};

  void updatePage(VoidCallback callback) {
    callback();
    onUpdate();
  }
  // TS_END_FFMODEL
`;

  if (result.includes('abstract class FlutterFlowModel')) {
    result = result.replace(/abstract class FlutterFlowModel<[^>]+>\s*\{/, `$& \n${injection}`);
  } else {
    result = result.replace(/class\s+FlutterFlowModel<[^>]+>\s*\{/, `$& \n${injection}`);
  }

  if (result.includes('_context = context;')) {
    result = result.replace('_context = context;', `_context = context;
    // TS_START_INIT_PUSH
    try {
      developer.postEvent('teamsoft.state', {
        'type': 'PageState',
        'page': this.runtimeType.toString(),
        'variables': ts_toMap(),
        'ts': DateTime.now().millisecondsSinceEpoch
      });
    } catch(_) {}
    // TS_END_INIT_PUSH`);
  }

  return result;
}

function injectIndividualModel(content, filePath) {
  let result = content.replace(/\s*\/\/ TS_START[\s\S]*?\/\/ TS_END\n/g, '');
  result = result.replace(/\s*\/\/ TS_START_LISTENERS[\s\S]*?\/\/ TS_END_LISTENERS\n/g, '');
  result = result.replace(/\s*try \{ _tsAttachListeners\(\); \} catch\(_\) \{\}\n/g, '');

  const classMatch = result.match(/class\s+([A-Za-z0-9_]+)\s+extends\s+FlutterFlowModel/);
  if (!classMatch) return content;

  result = safeInjectImport(result, "import '/flutter_flow/action_registry.dart';");

  const lines = result.split('\n');
  let widgetStatesCode = '', pageStatesCode = '', actionVarsCode = '', controllers = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (line.includes('class ') || line.includes('void ') || line.includes(' Future<') || line.includes(' get ')) continue;
    const isActionOutput = i > 0 && lines[i - 1].includes('// Stores action output result for');
    const fieldMatch = line.match(/^\s*(?:late\s+)?(?:final\s+)?([A-Z][a-zA-Z0-9_<>,? \[\]]*|dynamic\??|int\??|double\??|bool\??|String\??)\s+([a-zA-Z0-9_]+)(?:\s*=\s*[^;]+)?;/);
    
    if (fieldMatch) {
      const typeStr = fieldMatch[1], fName = fieldMatch[2];
      if (fName.endsWith('_enums') || fName.endsWith('_app_state') || fName.endsWith('_actions') || ['context', 'widget', 'prefs', 'scaffoldKey'].includes(fName)) continue;
      
      if (typeStr.includes('TextEditingController')) {
        widgetStatesCode += `        try { _widgetState['${fName.replace('TextController', '').replace('Controller', '')}'] = TSSerializer.serialize(${fName}?.text); } catch(_) {}\n`;
        controllers.push(fName); 
      } else if (typeStr.includes('FocusNode')) {
        widgetStatesCode += `        try { _widgetState['${fName.replace('FocusNode', '')} Focus'] = TSSerializer.serialize(${fName}?.hasFocus); } catch(_) {}\n`;
        controllers.push(fName); 
      } else if (fName.toLowerCase().includes('visibility') || fName.toLowerCase().includes('hover')) {
        widgetStatesCode += `        try { _widgetState['${fName}'] = TSSerializer.serialize(${fName}); } catch(_) {}\n`;
      } else if (isActionOutput) {
        actionVarsCode += `        try { _actionOutputs['${fName}'] = TSSerializer.serialize(${fName}); } catch(_) {}\n`;
      } else {
        pageStatesCode += `        try { _pageState['${fName}'] = TSSerializer.serialize(${fName}); } catch(_) {}\n`;
      }
    }
  }

  const tsToMapCode = `
  // TS_START
  @override
  Map<String, dynamic> ts_toMap() {
    Map<String, dynamic> _widgetState = {};
    Map<String, dynamic> _pageState = {};
    Map<String, dynamic> _actionOutputs = {};

    try {
      // V5.2 Puxa as Actions apenas do Cofre de Actions
      final globalData = globalActionOutputsRegistry['${classMatch[1]}'] ?? {};
      globalData.forEach((k, v) {
         _actionOutputs[k] = v;
      });

${widgetStatesCode}${actionVarsCode}${pageStatesCode}

      return {
        'WIDGET STATE': _widgetState,
        'PAGE STATE': _pageState,
        'ACTION OUTPUTS': _actionOutputs,
        '_ts_updated': DateTime.now().millisecondsSinceEpoch,
      };
    } catch(e) {
      return { 'error': e.toString(), 'page': '${classMatch[1]}' };
    }
  }
  // TS_END
`;
  result = result.replace(new RegExp(`(class\\s+${classMatch[1]}[^{]*{)`), `$1\n${tsToMapCode}`);
  
  if (controllers.length > 0) {
    const listeners = controllers.map(c => `      try { ${c}?.addListener(onUpdate); } catch(_) {}`).join('\n');
    const attachFunc = `\n  // TS_START_LISTENERS\n  void _tsAttachListeners() {\n    Future.delayed(const Duration(milliseconds: 200), () {\n${listeners}\n    });\n  }\n  // TS_END_LISTENERS\n`;
    
    result = result.replace(new RegExp(`(class\\s+${classMatch[1]}[^{]*{)`), `$1${attachFunc}`);
    
    if (result.includes('void initState(')) {
      result = result.replace(/(void\s+initState\([^)]*\)\s*\{)/, `$1\n    try { _tsAttachListeners(); } catch(_) {}\n`);
    } else {
      result = result.replace(new RegExp(`(class\\s+${classMatch[1]}[^{]*{)`), `$1\n  @override\n  void initState(BuildContext context) {\n    try { _tsAttachListeners(); } catch(_) {}\n  }\n`);
    }
  }

  if (result.includes('void dispose() {')) {
    result = result.replace(
      'void dispose() {',
      `void dispose() {\n    globalPageDataRegistry.remove('${classMatch[1]}');\n    globalActionOutputsRegistry.remove('${classMatch[1]}');\n`
    );
  } else if (result.includes('void dispose() =>')) {
    result = result.replace(
      /void dispose\(\)\s*=>\s*([^;]+);/,
      `void dispose() {\n    $1;\n    globalPageDataRegistry.remove('${classMatch[1]}');\n    globalActionOutputsRegistry.remove('${classMatch[1]}');\n  }`
    );
  }

  return result;
}

function injectWidgetActionOutput(content, filePath) {
  let result = content.replace(/\/\/ TS_START_ACTION[\s\S]*?\/\/ TS_END_ACTION\n?/g, '');
  result = result.replace(/^(\s*)try\s*\{\s*updateActionOutput\('[^']+',\s*'[^']+',\s*_model\.[^)]+\);\s*\}\s*catch\(_\)\s*\{\}\n?/gm, '');
  
  const assignmentRegex = /^\s*(_model\.([a-zA-Z0-9_]*output[a-zA-Z0-9_]*)\s*=\s*(?:await\s+)?[^;]+;)\s*$/gm;
  if (!assignmentRegex.test(result)) return result;
  
  result = safeInjectImport(result, "import 'dart:developer' as developer;");
  result = safeInjectImport(result, "import '/flutter_flow/action_registry.dart';");
  
  const widgetClassMatch = result.match(/class\s+(\w+)\s+extends\s+StatefulWidget/);
  const className = widgetClassMatch ? widgetClassMatch[1] : 'UnknownWidget';
  const scopeName = className.endsWith('Widget') ? className.replace('Widget', 'Model') : className + 'Model';
  
  result = result.replace(assignmentRegex, (match, p1, p2) => {
      if (match.includes('Uint8List') || match.includes('bytes') || match.includes('file') || match.includes('FFUploadedFile')) {
          return match;
      }
      return `${p1}\n    // TS_START_ACTION\n    try { updateActionOutput('${scopeName}', '${p2}', _model.${p2}); } catch(_) {}\n    // TS_END_ACTION`;
  });
  
  return result;
}

let _cachedPackageName = 'resultados_app';

async function inject(projectDir, onStatus) {
  onStatus('🧪 TeamSoft FF Studio V5.2 — Action Output Fix...');
  let actualRoot = projectDir;
  const mainFiles = findFile(projectDir, 'main.dart');
  if (mainFiles.length > 0) {
    const primaryMain = mainFiles.find(f => f.includes(path.sep + 'lib' + path.sep)) || mainFiles[0];
    actualRoot = path.dirname(path.dirname(primaryMain));
  }
  onStatus(`[LogInjector] Absolute root: ${actualRoot}`);

  ensureActionRegistryExists(actualRoot);
  try {
    const pubspec = fs.readFileSync(path.join(actualRoot, 'pubspec.yaml'), 'utf8');
    const nameMatch = pubspec.match(/^name:\s*([a-zA-Z0-9_]+)/m);
    if (nameMatch) {
      _cachedPackageName = nameMatch[1];
      onStatus(`[LogInjector] Package name detected: ${_cachedPackageName}`);
    }
  } catch (e) { onStatus(`[LogInjector] Warning: pubspec not found at ${actualRoot}`); }

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
      if (modified !== original) {
        backup(f);
        fs.writeFileSync(f, modified, 'utf8');
        count++;
      }
    }
    if (count > 0) onStatus(`✅ ${label} in ${count} files.`);
  };

  processFiles('app_state.dart', injectAppStateExtension, 'AppState');
  processFiles('main.dart', injectMain, 'Main extensions');
  processFiles('api_manager.dart', injectApiManager, 'API tracking');
  processFiles('flutter_flow_model.dart', injectFlutterFlowModel, 'FFModel base');
  processFiles('*_model.dart', injectIndividualModel, 'Individual models');
  processFiles('*_widget.dart', injectWidgetActionOutput, 'Widget actions');
  onStatus('✅ instrumentation complete.');
}

module.exports = { typeof: inject, findFile, inject, injectFlutterFlowModel };
