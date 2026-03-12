import 'dart:async';
import 'package:flutter/material.dart';
import 'socket_bridge.dart';
import 'state_tracker.dart';

class FFTelemetry {
  static final FFTelemetry _instance = FFTelemetry._internal();
  factory FFTelemetry() => _instance;
  FFTelemetry._internal();

  bool _initialized = false;
  
  // Callback for root to force rebuild
  Function? _forceRebuild;

  void initialize({Function? onRebuild}) {
    print('[FFStudio] Initializing Telemetry...');
    _initialized = true;
    _forceRebuild = onRebuild;

    // Connect to IDE
    SocketBridge().connect('ws://localhost:3000');
    print('[FFStudio] Telemetry Initialized');
  }

  void handleRollback(String key) {
    // Revert state object internally
    FFStateTracker.rollback(key);
    // Force a root app rebuild
    if (_forceRebuild != null) {
      _forceRebuild!();
    }
  }
}
