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

DateTime? currentDay;

dynamic getDayJson(int dia, int mes, int ano, bool forward) {
  final novaData = DateTime(ano, mes, dia);

  if (currentDay == null) {
    // primeira vez que chama, define a data inicial
    currentDay = novaData;
  } else {
    final mesmoDia = currentDay!.year == novaData.year &&
        currentDay!.month == novaData.month &&
        currentDay!.day == novaData.day;

    if (!mesmoDia) {
      // se clicou em outro dia, atualiza pra esse novo
      currentDay = novaData;
    } else {
      // se é o mesmo dia e clicou pra frente/atrás
      if (forward) {
        currentDay = currentDay!.add(const Duration(days: 1));
      } else {
        currentDay = currentDay!.subtract(const Duration(days: 1));
      }
    }
  }

  final formattedDay =
      "${currentDay!.year.toString().padLeft(4, '0')}-${currentDay!.month.toString().padLeft(2, '0')}-${currentDay!.day.toString().padLeft(2, '0')}";

  return {
    "dia": currentDay!.day,
    "mes": currentDay!.month,
    "ano": currentDay!.year,
    "formattedDay": formattedDay,
  };
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
