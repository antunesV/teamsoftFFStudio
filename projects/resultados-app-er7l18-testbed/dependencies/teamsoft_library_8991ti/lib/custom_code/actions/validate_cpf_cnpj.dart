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

Future<bool> validateCpfCnpj(
  String value,
  ValidationCpfCnpj type,
) async {
  // Add your function code here!
  String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

  bool isValidCpf(String cpf) {
    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    List<int> numbers = cpf.split('').map(int.parse).toList();

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }
    int firstDigit = (sum * 10 % 11) % 10;
    if (numbers[9] != firstDigit) return false;

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }
    int secondDigit = (sum * 10 % 11) % 10;
    if (numbers[10] != secondDigit) return false;

    return true;
  }

  bool isValidCnpj(String cnpj) {
    if (cnpj.length != 14) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;

    List<int> numbers = cnpj.split('').map(int.parse).toList();
    List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> weights2 = [6] + weights1;

    int sum = 0;
    for (int i = 0; i < 12; i++) sum += numbers[i] * weights1[i];
    int firstDigit = sum % 11;
    firstDigit = firstDigit < 2 ? 0 : 11 - firstDigit;
    if (numbers[12] != firstDigit) return false;

    sum = 0;
    for (int i = 0; i < 13; i++) sum += numbers[i] * weights2[i];
    int secondDigit = sum % 11;
    secondDigit = secondDigit < 2 ? 0 : 11 - secondDigit;
    if (numbers[13] != secondDigit) return false;

    return true;
  }

  final typeLowerCase = type.toString().toLowerCase().substring(18);

  print("type" + " ${typeLowerCase}");

  // Aqui usamos o enum que vem do FlutterFlow
  if (typeLowerCase.contains('cpf')) {
    return isValidCpf(cleaned);
  } else if (typeLowerCase.contains('cnpj')) {
    return isValidCnpj(cleaned);
  } else {
    // Ambos
    return isValidCpf(cleaned) || isValidCnpj(cleaned);
  }
}
