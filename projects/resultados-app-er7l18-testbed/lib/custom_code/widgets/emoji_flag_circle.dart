// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import "package:teamsoft_library_8991ti/backend/schema/structs/index.dart"
    as teamsoft_library_8991ti_data_schema;
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui';

class EmojiFlagCircle extends StatelessWidget {
  final String countryCode;
  final double width;
  final double height;

  const EmojiFlagCircle({
    Key? key,
    required this.countryCode,
    this.width = 32,
    this.height = 32,
  }) : super(key: key);

  String _flagFromCode(String code) {
    final base = 0x1F1E6;
    return code
        .toUpperCase()
        .codeUnits
        .map((c) => String.fromCharCode(base + (c - 65)))
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final flag = _flagFromCode(countryCode);
    final double size = width < height ? width : height;

    return SizedBox(
      width: width,
      height: height,
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Blur corretamente limitado ao círculo
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.10),
                ),
              ),
            ),

            // Emoji centralizado
            Center(
              child: Transform.scale(
                scale: 1.4,
                child: Text(
                  flag,
                  style: TextStyle(
                    fontSize: size,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
