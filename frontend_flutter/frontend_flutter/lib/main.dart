import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/debug_panel_screen.dart';
import 'services/socket_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: const TeamSoftDebugApp(),
    ),
  );
}

class TeamSoftDebugApp extends StatelessWidget {
  const TeamSoftDebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamSoft Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF09090B),
        primaryColor: const Color(0xFFFFD600),
      ),
      home: const DebugPanelScreen(),
    );
  }
}
