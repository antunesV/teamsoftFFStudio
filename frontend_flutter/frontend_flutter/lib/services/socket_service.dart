import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends ChangeNotifier {
  io.Socket? _socket;
  final StreamController<Map<String, dynamic>> _stateController = StreamController.broadcast();

  Stream<Map<String, dynamic>> get stateStream => _stateController.stream;

  void connect(String url) {
    if (_socket != null) return;
    
    // Conecta no Node.js local
    _socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket!.onConnect((_) {
      debugPrint('✅ Conectado ao Backend Node.js');
      requestRefresh();
    });

    _socket!.on('state-snapshot', (data) {
      if (data is Map) {
        _stateController.add(Map<String, dynamic>.from(data));
      }
    });
  }

  void requestRefresh() {
    _socket?.emit('request-initial-state');
  }

  @override
  void dispose() {
    _socket?.dispose();
    _stateController.close();
    super.dispose();
  }
}
