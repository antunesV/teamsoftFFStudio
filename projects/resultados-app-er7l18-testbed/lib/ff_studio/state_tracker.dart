import 'dart:convert';
import 'timeline.dart';

class FFStateTracker {
  static final Map<String, List<dynamic>> _snapshots = {};

  static void recordMutation(String stateKey, dynamic newValue) {
    if (!_snapshots.containsKey(stateKey)) {
      _snapshots[stateKey] = [];
    }
    _snapshots[stateKey]!.add(newValue);
    
    FFTimeline.record('state_change', {
      'key': stateKey,
      'value': newValue?.toString(),
    });
  }

  static void rollback(String stateKey) {
    // Rollback placeholder
    FFTimeline.record('state_rollback_executed', {
      'key': stateKey,
    });
  }
}
