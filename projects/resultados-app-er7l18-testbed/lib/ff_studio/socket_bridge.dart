import 'dart:html' as html;
import 'dart:convert';
import 'telemetry.dart';

class SocketBridge {
  static final SocketBridge _instance = SocketBridge._internal();
  factory SocketBridge() => _instance;
  SocketBridge._internal();

  html.WebSocket? _socket;
  bool _isConnected = false;

  void connect(String url) {
    try {
      print('[FFStudio] Connecting to IDE at $url...');
      _socket = html.WebSocket(url);
      
      _socket!.onOpen.listen((e) {
        _isConnected = true;
        print('[FFStudio] WebSocket connected to $url');
      });

      _socket!.onMessage.listen((e) {
        try {
          final data = jsonDecode(e.data);
          if (data['type'] == 'rollback_state') {
             // Let telemetry handle it
             FFTelemetry().handleRollback(data['key']);
          }
        } catch (err) {
          // ignore
        }
      });

      _socket!.onClose.listen((e) {
        _isConnected = false;
      });

      _socket!.onError.listen((e) {
        _isConnected = false;
      });
    } catch (e) {
      print('[FFStudio] WebSocket connection failed: $e');
    }
  }

  void send(String type, Map<String, dynamic> payload) {
    if (!_isConnected || _socket == null) return;
    try {
      _socket!.sendString(jsonEncode({'type': type, 'data': payload}));
    } catch (e) {
      // ignore
    }
  }
}
