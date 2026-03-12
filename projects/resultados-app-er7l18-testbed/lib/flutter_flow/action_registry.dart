/// Scoped registry to track data per page/model.
final Map<String, Map<String, dynamic>> globalPageDataRegistry = {};
String? activePageName;

/// Updates a value in the global registry for a specific scope (class name).
void updateActionOutput(String scope, String key, dynamic value) {
  globalPageDataRegistry.putIfAbsent(scope, () => {});
  globalPageDataRegistry[scope]![key] = value;
  activePageName = scope;
}

/// Updates the entire state for a specific scope.
void updatePageState(String scope, Map<String, dynamic> data) {
  globalPageDataRegistry[scope] = data;
  activePageName = scope;
}
