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

Future<dynamic> actionSearchObject(
  List<dynamic>? object,
  String? key,
  String? value,
) async {
  // Check if json, key, and value are not null
  if (object == null || key == null || value == null) {
    return null;
  }

  // Iterate through the list of JSON objects
  for (var obj in object) {
    // Check if the object is a map and contains the specified key
    if (obj is Map<String, dynamic> && obj.containsKey(key)) {
      // Check if the value associated with the key matches the specified value
      if (obj[key].toString() == value.toString()) {
        // Return the value associated with the key
        return obj;
      }
    }
  }

  // Return null if no match is found
  return null;
}
