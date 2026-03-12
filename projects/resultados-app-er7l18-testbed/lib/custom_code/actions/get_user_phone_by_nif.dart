// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import "package:teamsoft_library_8991ti/backend/schema/structs/index.dart"
    as teamsoft_library_8991ti_data_schema;
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> getUserPhoneByNif(String nif) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('user_data')
        .select('phone')
        .eq('nif', nif)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return response['phone'] as String?;
  } catch (e) {
    print('Erro ao buscar telefone: $e');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
