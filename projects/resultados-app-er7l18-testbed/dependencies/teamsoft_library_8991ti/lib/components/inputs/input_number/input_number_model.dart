import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'input_number_widget.dart' show InputNumberWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InputNumberModel extends FlutterFlowModel<InputNumberWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for exactNumber widget.
  FocusNode? exactNumberFocusNode;
  TextEditingController? exactNumberTextController;
  String? Function(BuildContext, String?)? exactNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    exactNumberFocusNode?.dispose();
    exactNumberTextController?.dispose();
  }
}
