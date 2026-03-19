import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends ChangeNotifier {
  io.Socket? _socket;
  
  final StreamController<Map<String, dynamic>> _stateController = StreamController.broadcast();
  final StreamController<String> _logController = StreamController.broadcast();
  final StreamController<List<Map<String, dynamic>>> _networkController = StreamController.broadcast();
  
  List<Map<String, dynamic>> networkHistory = []; 

  // Os getters públicos e seguros
  Stream<Map<String, dynamic>> get stateStream => _stateController.stream;
  Stream<String> get logStream => _logController.stream;
  Stream<List<Map<String, dynamic>>> get networkStream => _networkController.stream;
  
  // Fornecemos o getter do socket apenas para o botão "Sync" manual
  io.Socket? get socket => _socket;

  void connect(String url) {
    if (_socket != null) return;
    
    // 🚀 BLINDAGEM DE CONEXÃO: Tenta reconectar para sempre se o Node.js reiniciar
    _socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionDelay': 1000,
      'reconnectionDelayMax': 5000,
      'reconnectionAttempts': 99999,
    });

    _socket!.onConnect((_) {
      debugPrint('✅ Conectado ao Backend Node.js');
      requestRefresh();
    });

    _socket!.onDisconnect((_) {
      debugPrint('❌ Desconectado do Backend Node.js. Tentando reconectar...');
    });

    _socket!.on('log-history', (data) {
      if (data is List) for (var log in data) _logController.add(log.toString());
    });
    
    _socket!.on('log', (data) => _logController.add(data.toString()));

    _socket!.on('network-update', (data) {
      if (data is Map) {
        networkHistory.insert(0, Map<String, dynamic>.from(data));
        if (networkHistory.length > 50) networkHistory.removeLast(); 
        _networkController.add(List.from(networkHistory));
      }
    });

    _socket!.on('state-snapshot', (data) {
      if (data is Map) {
        _stateController.add(Map<String, dynamic>.from(data));
      }
    });
  }

  void requestRefresh() => _socket?.emit('request-initial-state');

  @override
  void dispose() {
    _socket?.dispose();
    _stateController.close();
    _logController.close();
    _networkController.close();
    super.dispose();
  }
}