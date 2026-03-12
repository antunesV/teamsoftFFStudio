import '/flutter_flow/action_registry.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/onboarding/components/select_country/select_country_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'professional_data_widget.dart' show ProfessionalDataWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfessionalDataModel extends FlutterFlowModel<ProfessionalDataWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
      },
      'Action Outputs': globalPageDataRegistry['ProfessionalDataModel'] ?? {},
      'Dados de Widget': {
        'pageViewController': (pageViewController?.hasClients == true && pageViewController?.page != null) ? pageViewController!.page!.round() : null,
        'textField1 Focus': textFieldFocusNode1?.hasFocus,
        'textField1': textFieldTextController1?.text,
        'textField2 Focus': textFieldFocusNode2?.hasFocus,
        'textField2': textFieldTextController2?.text,
        'textField3 Focus': textFieldFocusNode3?.hasFocus,
        'textField3': textFieldTextController3?.text,
        'textField4 Focus': textFieldFocusNode4?.hasFocus,
        'text4': textController4?.text,
        'textField5 Focus': textFieldFocusNode5?.hasFocus,
        'textField4': textFieldTextController4?.text,
        'textField6 Focus': textFieldFocusNode6?.hasFocus,
        'textField5': textFieldTextController5?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'abc': abc,
      'dropDownValue1': dropDownValue1,
      'dropDownValueController1': dropDownValueController1,
      'dropDownValue2': dropDownValue2,
      'dropDownValueController2': dropDownValueController2,
      'dropDownValue3': dropDownValue3,
      'dropDownValueController3': dropDownValueController3,
      'dropDownValue4': dropDownValue4,
      'dropDownValueController4': dropDownValueController4,
      'isDataUploading_uploadDataF80': isDataUploading_uploadDataF80,
      'checkboxListTileValue1': checkboxListTileValue1,
      'checkboxListTileValue2': checkboxListTileValue2,
      'checkboxListTileValue3': checkboxListTileValue3,
      'checkboxListTileValue4': checkboxListTileValue4,
      'checkboxListTileValue5': checkboxListTileValue5,
      'checkboxListTileValue6': checkboxListTileValue6,
      'checkboxListTileValue7': checkboxListTileValue7,
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

  bool abc = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textFieldTextController1;
  String? Function(BuildContext, String?)? textFieldTextController1Validator;
  bool isDataUploading_uploadDataF80 = false;
  FFUploadedFile uploadedLocalFile_uploadDataF80 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textFieldTextController2;
  String? Function(BuildContext, String?)? textFieldTextController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textFieldTextController3;
  String? Function(BuildContext, String?)? textFieldTextController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textFieldTextController4;
  String? Function(BuildContext, String?)? textFieldTextController4Validator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue3;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue4;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue5;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue6;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue7;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textFieldTextController5;
  String? Function(BuildContext, String?)? textFieldTextController5Validator;

  @override
  void initState(BuildContext context) {
    textFieldTextController1?.addListener(onUpdate);
    textFieldTextController2?.addListener(onUpdate);
    textFieldTextController3?.addListener(onUpdate);
    textController4?.addListener(onUpdate);
    textFieldTextController4?.addListener(onUpdate);
    textFieldTextController5?.addListener(onUpdate);}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textFieldTextController1?.dispose();

    textFieldFocusNode2?.dispose();
    textFieldTextController2?.dispose();

    textFieldFocusNode3?.dispose();
    textFieldTextController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textFieldTextController4?.dispose();

    textFieldFocusNode6?.dispose();
    textFieldTextController5?.dispose();
  }
}
