import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'drop_down_calendar_widget.dart' show DropDownCalendarWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class DropDownCalendarModel extends FlutterFlowModel<DropDownCalendarWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for initialDate widget.
  FocusNode? initialDateFocusNode;
  TextEditingController? initialDateTextController;
  late MaskTextInputFormatter initialDateMask;
  String? Function(BuildContext, String?)? initialDateTextControllerValidator;
  DateTime? datePicked1;
  // State field(s) for finalDate widget.
  FocusNode? finalDateFocusNode;
  TextEditingController? finalDateTextController;
  late MaskTextInputFormatter finalDateMask;
  String? Function(BuildContext, String?)? finalDateTextControllerValidator;
  DateTime? datePicked2;
  // State field(s) for exactInitialDate widget.
  FocusNode? exactInitialDateFocusNode;
  TextEditingController? exactInitialDateTextController;
  late MaskTextInputFormatter exactInitialDateMask;
  String? Function(BuildContext, String?)?
      exactInitialDateTextControllerValidator;
  DateTime? datePicked3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    initialDateFocusNode?.dispose();
    initialDateTextController?.dispose();

    finalDateFocusNode?.dispose();
    finalDateTextController?.dispose();

    exactInitialDateFocusNode?.dispose();
    exactInitialDateTextController?.dispose();
  }
}
