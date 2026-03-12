import '/flutter_flow/action_registry.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/shared/error_msg/error_msg_widget.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'forgot_password_widget.dart' show ForgotPasswordWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:teamsoft_library_8991ti/custom_code/actions/index.dart'
    as teamsoft_library_8991ti_actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordModel extends FlutterFlowModel<ForgotPasswordWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
      },
      'Action Outputs': globalPageDataRegistry['ForgotPasswordModel'] ?? {},
      'Dados de Widget': {
        'pageViewController': (pageViewController?.hasClients == true && pageViewController?.page != null) ? pageViewController!.page!.round() : null,
        'email1 Focus': emailFocusNode1?.hasFocus,
        'email1': emailTextController1?.text,
        'email2 Focus': emailFocusNode2?.hasFocus,
        'email2': emailTextController2?.text,
        'input0 Focus': input0FocusNode?.hasFocus,
        'input0': input0TextController?.text,
        'input1 Focus': input1FocusNode?.hasFocus,
        'input1': input1TextController?.text,
        'input2 Focus': input2FocusNode?.hasFocus,
        'input2': input2TextController?.text,
        'input3 Focus': input3FocusNode?.hasFocus,
        'input3': input3TextController?.text,
        'input4 Focus': input4FocusNode?.hasFocus,
        'input4': input4TextController?.text,
        'input5 Focus': input5FocusNode?.hasFocus,
        'input5': input5TextController?.text,
        'textField1 Focus': textFieldFocusNode1?.hasFocus,
        'text9': textController9?.text,
        'textField2 Focus': textFieldFocusNode2?.hasFocus,
        'text10': textController10?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'resetMethod': resetMethod,
      'validation': validation,
      'emailRecover': emailRecover,
      'finalCode': finalCode,
      'splitedCode': splitedCode,
      'toggleTimer': toggleTimer,
      'jwt': jwt,
      'refreshToken': refreshToken,
      'uploadedSelfie': uploadedSelfie,
      'passwordComparison': passwordComparison,
      'confirmReseted': confirmReseted,
      '[Action] outputValidation': outputValidation,
      '[Action] resetPass': resetPass,
      '[Action] smsCodeSent': smsCodeSent,
      '[Action] userPhone': userPhone,
      '[Action] validateToken': validateToken,
      'timerMilliseconds': timerMilliseconds,
      '[Action] apiResulto1s': apiResulto1s,
      '[Action] sendSMS': sendSMS,
      'passwordVisibility1': passwordVisibility1,
      'passwordVisibility2': passwordVisibility2,
      '[Action] passwordChange': passwordChange,
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

  bool resetMethod = true;

  dynamic validation;

  String? emailRecover;

  String? finalCode;

  List<String> splitedCode = [];
  void addToSplitedCode(String item) => splitedCode.add(item);
  void removeFromSplitedCode(String item) => splitedCode.remove(item);
  void removeAtIndexFromSplitedCode(int index) => splitedCode.removeAt(index);
  void insertAtIndexInSplitedCode(int index, String item) =>
      splitedCode.insert(index, item);
  void updateSplitedCodeAtIndex(int index, Function(String) updateFn) =>
      splitedCode[index] = updateFn(splitedCode[index]);

  bool toggleTimer = false;

  String? jwt;

  String? refreshToken;

  FFUploadedFile? uploadedSelfie;

  bool passwordComparison = false;

  dynamic confirmReseted;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  // Stores action output result for [Custom Action - validateData] action in Button widget.
  dynamic? outputValidation;
  // Stores action output result for [Backend Call - API (resetPassword)] action in Button widget.
  ApiCallResponse? resetPass;
  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;
  // Stores action output result for [Backend Call - API (resetPasswordSMS)] action in Button widget.
  ApiCallResponse? smsCodeSent;
  // Stores action output result for [Custom Action - getUserPhoneByNif] action in Button widget.
  String? userPhone;
  // State field(s) for input0 widget.
  FocusNode? input0FocusNode;
  TextEditingController? input0TextController;
  String? Function(BuildContext, String?)? input0TextControllerValidator;
  // State field(s) for input1 widget.
  FocusNode? input1FocusNode;
  TextEditingController? input1TextController;
  String? Function(BuildContext, String?)? input1TextControllerValidator;
  // State field(s) for input2 widget.
  FocusNode? input2FocusNode;
  TextEditingController? input2TextController;
  String? Function(BuildContext, String?)? input2TextControllerValidator;
  // State field(s) for input3 widget.
  FocusNode? input3FocusNode;
  TextEditingController? input3TextController;
  String? Function(BuildContext, String?)? input3TextControllerValidator;
  // State field(s) for input4 widget.
  FocusNode? input4FocusNode;
  TextEditingController? input4TextController;
  String? Function(BuildContext, String?)? input4TextControllerValidator;
  // State field(s) for input5 widget.
  FocusNode? input5FocusNode;
  TextEditingController? input5TextController;
  String? Function(BuildContext, String?)? input5TextControllerValidator;
  // Stores action output result for [Backend Call - API (validateToken)] action in Button widget.
  ApiCallResponse? validateToken;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 60000;
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    minute: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (resetPassword)] action in Row widget.
  ApiCallResponse? apiResulto1s;
  // Stores action output result for [Backend Call - API (resetPasswordSMS)] action in Row widget.
  ApiCallResponse? sendSMS;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController9;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController10;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController10Validator;
  // Stores action output result for [Backend Call - API (changePassword)] action in Button widget.
  ApiCallResponse? passwordChange;

  @override
  void initState(BuildContext context) {
    emailTextController1?.addListener(onUpdate);
    emailTextController2?.addListener(onUpdate);
    input0TextController?.addListener(onUpdate);
    input1TextController?.addListener(onUpdate);
    input2TextController?.addListener(onUpdate);
    input3TextController?.addListener(onUpdate);
    input4TextController?.addListener(onUpdate);
    input5TextController?.addListener(onUpdate);
    textController9?.addListener(onUpdate);
    textController10?.addListener(onUpdate);
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    emailFocusNode1?.dispose();
    emailTextController1?.dispose();

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();

    input0FocusNode?.dispose();
    input0TextController?.dispose();

    input1FocusNode?.dispose();
    input1TextController?.dispose();

    input2FocusNode?.dispose();
    input2TextController?.dispose();

    input3FocusNode?.dispose();
    input3TextController?.dispose();

    input4FocusNode?.dispose();
    input4TextController?.dispose();

    input5FocusNode?.dispose();
    input5TextController?.dispose();

    timerController.dispose();
    textFieldFocusNode1?.dispose();
    textController9?.dispose();

    textFieldFocusNode2?.dispose();
    textController10?.dispose();
  }
}
