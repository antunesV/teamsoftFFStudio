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

Future customNavigation(
  BuildContext context,
  String page,
  dynamic? item,
) async {
  if (page.isEmpty) {
    return;
  }
  try {
    if (item.isNotEmpty && item["route"] == true) {
      print("True");
      await context.push(item["page"]);
    } else {
      print("false");
      await GoRouter.of(context).pushNamed(page);
    }
  } catch (e) {
    // Handle navigation error gracefully
    debugPrint('Navigation error: $e');
  }
}
