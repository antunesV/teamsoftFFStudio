import 'dart:developer' as developer;
import 'dart:convert';

final Map<String, Map<String, dynamic>> globalPageDataRegistry = {};
String? activePageName;

void updateActionOutput(String scope, String key, dynamic value) {
  if (!globalPageDataRegistry.containsKey(scope)) {
    globalPageDataRegistry[scope] = {};
  }
  globalPageDataRegistry[scope]![key] = value;
  _notifyStateChange(scope);
}

void updatePageState(String scope, Map<String, dynamic> data) {
  globalPageDataRegistry[scope] = data;
  _notifyStateChange(scope);
}

void _notifyStateChange(String scope) {
  try {
    developer.postEvent('teamsoft.state', {
      'type': 'PageState',
      'page': scope,
      'variables': globalPageDataRegistry[scope] ?? {},
      'ts': DateTime.now().millisecondsSinceEpoch,
    });
  } catch (_) {}
}
