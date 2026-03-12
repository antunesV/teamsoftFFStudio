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

//
/*
validationConfig
{
  "name": {
    "value": "abc",
    "validation": {
      "rule": "REQUIRED", // USAR ENUM ValidationRules
      "errorMsg": "Campo obrigatório"
      "validate": true
    }
  },
  "idade": {
    "value": 17,
    "validation": {
      "rule": "GREATER_THAN_OR_EQUAL", // USAR ENUM ValidationRules
      "value": 18,
      "errorMsg": "Deve ser maior que 18 anos"
      "validate": true
    }
  },
  "Password": {
    "value": "XPTO123",
    "validation": {
      "rule": "EQUAL", // USAR ENUM ValidationRules
      "value": "XPTO123",
      "errorMsg": "Deve ser maior que 18 anos"
      "validate": true
    }
  }
}
*/

Future<dynamic> validateData(dynamic validationConfig) async {
  // Add your function code here!

  debugPrint(validationConfig.toString());

  dynamic validationReturn = {};
  bool valid = true;

  // Helpers locais
  bool _isValidEmail(String v) {
    final s = (v).trim();
    if (s.isEmpty) return false;
    final reg = RegExp(r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
        caseSensitive: false);
    return reg.hasMatch(s);
  }

  String _digits(String s) => s.replaceAll(RegExp(r'\D'), '');

  bool _isValidCPF(String v) {
    final cpf = _digits(v);
    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) return false;

    int _dv(List<int> nums, int factor) {
      var sum = 0;
      for (var n in nums) sum += n * factor--;
      final mod = sum % 11;
      return (mod < 2) ? 0 : 11 - mod;
    }

    final nums = cpf.split('').map(int.parse).toList();
    final d1 = _dv(nums.sublist(0, 9), 10);
    final d2 = _dv([...nums.sublist(0, 9), d1], 11);
    return nums[9] == d1 && nums[10] == d2;
  }

  bool _isValidCNPJ(String v) {
    final cnpj = _digits(v);
    if (cnpj.length != 14) return false;
    if (RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) return false;

    int _calc(List<int> ns, List<int> w) {
      var sum = 0;
      for (var i = 0; i < w.length; i++) sum += ns[i] * w[i];
      final mod = sum % 11;
      return (mod < 2) ? 0 : 11 - mod;
    }

    final ns = cnpj.split('').map(int.parse).toList();
    final w1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final w2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    final d1 = _calc(ns, w1);
    final d2 = _calc([...ns.sublist(0, 12), d1], w2);

    return ns[12] == d1 && ns[13] == d2;
  }

  validationConfig.entries.forEach((entry) {
    final key = entry.key;
    final cfg = entry.value;
    final rule = cfg["validation"]?["rule"]?.toString() ?? '';
    final errorMsg = cfg["validation"]?["errorMsg"]?.toString() ?? 'Inválido';
    final value = cfg["value"];
    final ruleValue = cfg["validation"]?["value"];

    // ✅ validate padrão true
    final validateFlag = cfg["validation"]?["validate"];
    final validate = validateFlag is bool ? validateFlag : true;

    // Conversões inline (como você pediu)
    final num? parsedValue = num.tryParse('${value}');
    final num? parsedRule = num.tryParse('${ruleValue}');

    // ✅ Se não deve validar, passa direto
    if (!validate) {
      validationReturn[key] = {"errorMsg": null};
      return;
    }

    // ---------------- REGRAS ----------------

    if (rule == 'REQUIRED' &&
        (value == null ||
            (value is String && value.trim().isEmpty) ||
            (value is String && value.trim().toLowerCase() == 'null'))) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'EQUAL' && value != ruleValue) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'GREATER_THAN' &&
        ((parsedValue ?? double.nan) > (parsedRule ?? double.nan)) == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'GREATER_THAN_OR_EQUAL' &&
        ((parsedValue ?? double.nan) >= (parsedRule ?? double.nan)) == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'LESS_THAN' &&
        ((parsedValue ?? double.nan) < (parsedRule ?? double.nan)) == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'LESS_THAN_OR_EQUAL' &&
        ((parsedValue ?? double.nan) <= (parsedRule ?? double.nan)) == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'EMAIL' &&
        _isValidEmail(value?.toString() ?? '') == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'CPF' && _isValidCPF(value?.toString() ?? '') == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else if (rule == 'CNPJ' &&
        _isValidCNPJ(value?.toString() ?? '') == false) {
      validationReturn[key] = {"errorMsg": errorMsg};
      valid = false;
    } else {
      validationReturn[key] = {"errorMsg": null};
    }
  });

  debugPrint({"valid": valid, "fields": validationReturn}.toString());

  return {"valid": valid, "fields": validationReturn};
}
