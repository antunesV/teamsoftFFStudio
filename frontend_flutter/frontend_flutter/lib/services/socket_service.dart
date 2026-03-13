import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends ChangeNotifier {
  io.Socket? _socket;
  
  final StreamController<Map<String, dynamic>> _stateController = StreamController.broadcast();
  final StreamController<String> _logController = StreamController.broadcast();
  // 🚀 NOVO: Stream do Network
  final StreamController<List<Map<String, dynamic>>> _networkController = StreamController.broadcast();
  
  List<Map<String, dynamic>> routeHistory = [];
  List<Map<String, dynamic>> networkHistory = []; // Memória das Requisições
  String? currentRoute;

  Stream<Map<String, dynamic>> get stateStream => _stateController.stream;
  Stream<String> get logStream => _logController.stream;
  Stream<List<Map<String, dynamic>>> get networkStream => _networkController.stream;

  void connect(String url) {
    if (_socket != null) return;
    
    _socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket!.onConnect((_) {
      debugPrint('✅ Conectado ao Backend Node.js');
      requestRefresh();
    });

    _socket!.on('log-history', (data) {
      if (data is List) for (var log in data) _logController.add(log.toString());
    });
    _socket!.on('log', (data) => _logController.add(data.toString()));

    // 🚀 NOVO: Escuta as chamadas de API em tempo real
    _socket!.on('network-update', (data) {
      if (data is Map) {
        networkHistory.insert(0, Map<String, dynamic>.from(data)); // Joga pro topo
        if (networkHistory.length > 50) networkHistory.removeLast(); // Limite de 50 requests
        _networkController.add(List.from(networkHistory));
      }
    });

    _socket!.on('state-snapshot', (data) {
      if (data is Map) {
        final mapData = Map<String, dynamic>.from(data);
        final activePage = mapData['active_page'];
        if (activePage != null && activePage != 'Unknown' && activePage != currentRoute) {
          currentRoute = activePage;
          routeHistory.insert(0, {'route': activePage, 'timestamp': DateTime.now()});
          if (routeHistory.length > 20) routeHistory.removeLast();
        }
        mapData['_routeHistory'] = routeHistory;
        _stateController.add(mapData);
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