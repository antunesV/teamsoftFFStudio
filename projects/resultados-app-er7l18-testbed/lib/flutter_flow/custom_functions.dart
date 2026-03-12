import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';
import "package:teamsoft_library_8991ti/backend/schema/structs/index.dart"
    as teamsoft_library_8991ti_data_schema;
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:teamsoft_library_8991ti/flutter_flow/custom_functions.dart'
    as teamsoft_library_8991ti_functions;

String returnCountry(String countryCode) {
  final base = 0x1F1E6;
  return countryCode.toUpperCase().codeUnits.map((c) {
    return String.fromCharCode(base + (c - 65));
  }).join();
}

List<dynamic> filterContries(
  String? value,
  List<dynamic> countries,
) {
  String normalize(String text) {
    const withAccent = 'áàãâäÁÀÃÂÄéèêëÉÈÊËíìîïÍÌÎÏóòõôöÓÒÕÔÖúùûüÚÙÛÜçÇ';
    const withoutAccent = 'aaaaaAAAAAeeeeEEEEiiiiIIIIoooooOOOOOuuuuUUUUcC';

    for (int i = 0; i < withAccent.length; i++) {
      text = text.replaceAll(withAccent[i], withoutAccent[i]);
    }

    return text;
  }

  if (value == null || value.isEmpty) {
    return countries;
  }

  final search = normalize(value.toLowerCase());
  List<dynamic> filteredCountries = [];

  for (var country in countries) {
    final countryMap = country as Map<String, dynamic>;

    final countryName = normalize(
      countryMap["pais"]?.toString().toLowerCase() ?? "",
    );

    if (countryName.contains(search)) {
      filteredCountries.add(country);
    }
  }

  return filteredCountries;
}

String? normalizePhone(String phone) {
  if (phone.isEmpty) return "";

  // 1️⃣ Remove todos caracteres que não sejam números
  String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

  // 2️⃣ Remove zeros extras após o código do país
  if (cleaned.startsWith('+55')) {
    cleaned = '+55' + cleaned.substring(3).replaceFirst(RegExp(r'^0+'), '');
  } else if (cleaned.startsWith('55')) {
    cleaned = '+55' + cleaned.substring(2).replaceFirst(RegExp(r'^0+'), '');
  } else {
    cleaned = '+55' + cleaned.replaceFirst(RegExp(r'^0+'), '');
  }

  return cleaned;
}

List<dynamic> searchFilter(
  String? value,
  List<dynamic> data,
  List<dynamic> fields,
) {
  String normalize(String text) {
    const withAccent = 'áàãâäÁÀÃÂÄéèêëÉÈÊËíìîïÍÌÎÏóòõôöÓÒÕÔÖúùûüÚÙÛÜçÇ';
    const withoutAccent = 'aaaaaAAAAAeeeeEEEEiiiiIIIIoooooOOOOOuuuuUUUUcC';

    for (int i = 0; i < withAccent.length; i++) {
      text = text.replaceAll(withAccent[i], withoutAccent[i]);
    }

    return text;
  }

  if (value == null || value.trim().isEmpty) {
    return data;
  }

  final search = normalize(value.toLowerCase());

  bool matchField(dynamic item, String fieldPath) {
    final keys = fieldPath.split('.');
    dynamic current = item;

    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];

      if (current is Map<String, dynamic>) {
        current = current[key];
      } else if (current is List) {
        // Se for lista, verifica se algum item interno bate
        return current
            .any((element) => matchField(element, keys.sublist(i).join('.')));
      } else {
        return false;
      }
    }

    if (current == null) return false;

    final normalizedValue = normalize(current.toString().toLowerCase());

    return normalizedValue.contains(search);
  }

  return data.where((item) {
    for (final field in fields) {
      if (matchField(item, field)) {
        return true;
      }
    }
    return false;
  }).toList();
}
