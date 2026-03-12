import '/flutter_flow/action_registry.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/shared/error_msg/error_msg_widget.dart';
import 'dart:ui';
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:teamsoft_library_8991ti/app_state.dart'
    as teamsoft_library_8991ti_app_state;
import 'package:teamsoft_library_8991ti/custom_code/actions/index.dart'
    as teamsoft_library_8991ti_actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
      },
      'Action Outputs': globalPageDataRegistry['LoginModel'] ?? {},
      'Dados de Widget': {
        'pageViewController': (pageViewController?.hasClients == true && pageViewController?.page != null) ? pageViewController!.page!.round() : null,
        'textField1 Focus': textFieldFocusNode1?.hasFocus,
        'text1': textController1?.text,
        'textField2 Focus': textFieldFocusNode2?.hasFocus,
        'text2': textController2?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'validateData': validateData,
      'passwordVisibility': passwordVisibility,
      '[Action] outputValidateData': outputValidateData,
      '[Action] loginOutput': loginOutput,
      '_ts_updated': DateTime.now().millisecondsSinceEpoch,
    };
  }
  // TS_END_TOMAP

  // Global Action Output Registry for TeamSoft instrumentation
  // Removed local registry to use global one from action_registry.dart


  // Redundant Action Output Registry for TeamSoft instrumentation
  final Map<String, dynamic> actionOutputRegistry = {};


  // Redundant Action Output Registry for TeamSoft instrumentation
  final Map<String, dynamic> actionOutputRegistry = {};






  ///  Local state fields for this page.

  dynamic validateData;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - validateData] action in Button widget.
  dynamic? outputValidateData;
  // Stores action output result for [Custom Action - loginUser] action in Button widget.
  dynamic? loginOutput;

  @override
  void initState(BuildContext context) {
    textController1?.addListener(onUpdate);
    textController2?.addListener(onUpdate);
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
