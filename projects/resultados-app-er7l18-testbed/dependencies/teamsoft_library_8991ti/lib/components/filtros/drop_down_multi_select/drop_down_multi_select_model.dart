import '/backend/schema/enums/enums.dart';
import '/components/inputs/input_checkbox/input_checkbox_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'drop_down_multi_select_widget.dart' show DropDownMultiSelectWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DropDownMultiSelectModel
    extends FlutterFlowModel<DropDownMultiSelectWidget> {
  ///  Local state fields for this component.

  List<dynamic> listSelectedDropDown = [];
  void addToListSelectedDropDown(dynamic item) =>
      listSelectedDropDown.add(item);
  void removeFromListSelectedDropDown(dynamic item) =>
      listSelectedDropDown.remove(item);
  void removeAtIndexFromListSelectedDropDown(int index) =>
      listSelectedDropDown.removeAt(index);
  void insertAtIndexInListSelectedDropDown(int index, dynamic item) =>
      listSelectedDropDown.insert(index, item);
  void updateListSelectedDropDownAtIndex(
          int index, Function(dynamic) updateFn) =>
      listSelectedDropDown[index] = updateFn(listSelectedDropDown[index]);

  bool add = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for inputCheckbox dynamic component.
  late FlutterFlowDynamicModels<InputCheckboxModel> inputCheckboxModels2;
  // Models for inputCheckbox dynamic component.
  late FlutterFlowDynamicModels<InputCheckboxModel> inputCheckboxModels4;

  @override
  void initState(BuildContext context) {
    inputCheckboxModels2 = FlutterFlowDynamicModels(() => InputCheckboxModel());
    inputCheckboxModels4 = FlutterFlowDynamicModels(() => InputCheckboxModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    inputCheckboxModels2.dispose();
    inputCheckboxModels4.dispose();
  }
}
