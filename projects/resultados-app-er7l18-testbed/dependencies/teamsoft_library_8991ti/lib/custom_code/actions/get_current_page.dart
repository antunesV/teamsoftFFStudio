// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// crie uma custom action para retornar qual a página atual

Future<String?> getCurrentPage(BuildContext context) async {
  final routes = GoRouter.of(context).configuration.routes;

  final currentLocation = GoRouter.of(context).getCurrentLocation();
  String routePath = currentLocation.split('?')[0];

  final rotaEncontrada = routes.firstWhere(
    (route) => route is GoRoute && route.path == routePath,
  );

  debugPrint('Achou: ${(rotaEncontrada as GoRoute).name}');

  return (rotaEncontrada as GoRoute).name;
}
