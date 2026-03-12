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

// Variável para guardar a semana atual
DateTime? currentWeekStart;

DateTime _weekStart(DateTime d) {
  final monday = d.subtract(Duration(days: d.weekday - 1));
  return DateTime(monday.year, monday.month, monday.day);
}

dynamic getWeekDaysJson(int dia, int mes, int ano, bool forward, bool isToday) {
  final today = DateTime.now();
  final novaData = DateTime(ano, mes, dia);
  final novaWeekStart = _weekStart(novaData);

  if (isToday) {
    // 🔹 Apenas reseta para a semana atual (semana do dia de hoje)
    currentWeekStart = _weekStart(today);
  } else if (currentWeekStart == null) {
    currentWeekStart = novaWeekStart;
  } else {
    final semanaInicio = currentWeekStart!;
    final semanaFim = semanaInicio.add(const Duration(days: 6));

    final estaNaSemanaAtual =
        !novaData.isBefore(semanaInicio) && !novaData.isAfter(semanaFim);

    if (!estaNaSemanaAtual) {
      currentWeekStart = novaWeekStart;
    } else if (forward) {
      currentWeekStart = currentWeekStart!.add(const Duration(days: 7));
    } else {
      currentWeekStart = currentWeekStart!.subtract(const Duration(days: 7));
    }
  }

  List<Map<String, dynamic>> dias = List.generate(7, (i) {
    final day = currentWeekStart!.add(Duration(days: i));
    final formattedDay =
        "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";

    return {
      "dia": day.day,
      "mes": day.month,
      "ano": day.year,
      "formattedDay": formattedDay,
    };
  });

  return {
    "dias": dias,
    "mesInicio": dias.first["mes"],
    "anoInicio": dias.first["ano"],
    "mesFim": dias.last["mes"],
    "anoFim": dias.last["ano"],
  };
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
