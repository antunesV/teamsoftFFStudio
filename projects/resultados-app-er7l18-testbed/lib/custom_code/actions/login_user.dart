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

Future<dynamic> loginUser(
  String nif,
  String password,
) async {
  final supabase = Supabase.instance.client;

  try {
    // 1️⃣ BUSCAR EMAIL PELO NIF
    final userInfo = await supabase
        .from('user_data')
        .select('email')
        .eq('nif', nif)
        .maybeSingle();

    if (userInfo == null || userInfo['email'] == null) {
      return {
        'ok': false,
        'error': 'NIF ou senha inválidos',
      };
    }

    final String email = userInfo['email'];

    // 2️⃣ LOGIN NO SUPABASE AUTH
    final authResponse = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (authResponse.user == null) {
      return {
        'ok': false,
        'error': 'NIF ou senha inválidos',
      };
    }

    final userId = authResponse.user!.id;

    // 3️⃣ BUSCAR DADOS COMPLEMENTARES
    final userData = await supabase
        .from('user_data')
        .select('*')
        .eq('user_id', userId)
        .maybeSingle();

    if (userData == null) {
      return {
        'ok': false,
        'error': 'Dados do usuário não encontrados',
      };
    }

    // 4️⃣ RETORNO FINAL (igual ao seu original)
    return {
      'ok': true,
      'userData': userData,
      'user': authResponse.user,
      'session': authResponse.session,
    };
  } catch (e) {
    return {
      'ok': false,
      'error': e.toString(),
    };
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
