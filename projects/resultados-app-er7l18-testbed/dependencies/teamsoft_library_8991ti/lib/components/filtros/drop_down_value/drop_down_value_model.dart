import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'drop_down_value_widget.dart' show DropDownValueWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DropDownValueModel extends FlutterFlowModel<DropDownValueWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for inicialValue widget.
  FocusNode? inicialValueFocusNode;
  TextEditingController? inicialValueTextController;
  String? Function(BuildContext, String?)? inicialValueTextControllerValidator;
  // State field(s) for finalValue widget.
  FocusNode? finalValueFocusNode;
  TextEditingController? finalValueTextController;
  String? Function(BuildContext, String?)? finalValueTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inicialValueFocusNode?.dispose();
    inicialValueTextController?.dispose();

    finalValueFocusNode?.dispose();
    finalValueTextController?.dispose();
  }
}
