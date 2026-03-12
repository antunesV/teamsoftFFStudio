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

Future<List<String>> stringToArray(String input, int ignoreCount) async {
  // Split the input string into words
  List<String> words = input.split(' ');

  // Check if ignoreCount is greater than the number of words
  if (ignoreCount >= words.length) {
    return []; // Return an empty list if ignoreCount is too high
  }

  // Return the list of words, ignoring the specified number of indexes
  return words.sublist(ignoreCount);
}
