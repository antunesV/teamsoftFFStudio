import 'socket_bridge.dart';

class FFTimeline {
  static void record(String eventType, Map<String, dynamic> payload) {
    final entry = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'eventType': eventType,
      ...payload
    };
    
    SocketBridge().send(eventType, entry);
  }
}
