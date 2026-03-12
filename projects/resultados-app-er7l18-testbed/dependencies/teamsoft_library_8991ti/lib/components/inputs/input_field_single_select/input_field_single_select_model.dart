import '/backend/schema/enums/enums.dart';
import '/components/inputs/input_single_select/input_single_select_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'input_field_single_select_widget.dart'
    show InputFieldSingleSelectWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InputFieldSingleSelectModel
    extends FlutterFlowModel<InputFieldSingleSelectWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for inputSingleSelect component.
  late InputSingleSelectModel inputSingleSelectModel;

  @override
  void initState(BuildContext context) {
    inputSingleSelectModel =
        createModel(context, () => InputSingleSelectModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    inputSingleSelectModel.dispose();
  }
}
