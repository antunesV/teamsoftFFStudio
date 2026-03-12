import '/flutter_flow/action_registry.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/shared/select_bottom_sheet/select_bottom_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:teamsoft_library_8991ti/app_state.dart'
    as teamsoft_library_8991ti_app_state;
import 'personal_data_widget.dart' show PersonalDataWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalDataModel extends FlutterFlowModel<PersonalDataWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
      },
      'Action Outputs': globalPageDataRegistry['PersonalDataModel'] ?? {},
      'Dados de Widget': {
        'pageViewController': (pageViewController?.hasClients == true && pageViewController?.page != null) ? pageViewController!.page!.round() : null,
        'textField1 Focus': textFieldFocusNode1?.hasFocus,
        'text1': textController1?.text,
        'textField2 Focus': textFieldFocusNode2?.hasFocus,
        'text2': textController2?.text,
        'textField3 Focus': textFieldFocusNode3?.hasFocus,
        'text3': textController3?.text,
        'textField4 Focus': textFieldFocusNode4?.hasFocus,
        'text4': textController4?.text,
        'gender1 Focus': genderFocusNode1?.hasFocus,
        'gender1': genderTextController1?.text,
        'textField5 Focus': textFieldFocusNode5?.hasFocus,
        'text6': textController6?.text,
        'maritalStatus1 Focus': maritalStatusFocusNode1?.hasFocus,
        'maritalStatus1': maritalStatusTextController1?.text,
        'birthCountry1 Focus': birthCountryFocusNode1?.hasFocus,
        'birthCountry1': birthCountryTextController1?.text,
        'province1 Focus': provinceFocusNode1?.hasFocus,
        'province1': provinceTextController1?.text,
        'ddi1 Focus': ddiFocusNode1?.hasFocus,
        'ddi1': ddiTextController1?.text,
        'cellphone1 Focus': cellphoneFocusNode1?.hasFocus,
        'cellphone1': cellphoneTextController1?.text,
        'ddi2 Focus': ddiFocusNode2?.hasFocus,
        'ddi2': ddiTextController2?.text,
        'cellphone2 Focus': cellphoneFocusNode2?.hasFocus,
        'cellphone2': cellphoneTextController2?.text,
        'email1 Focus': emailFocusNode1?.hasFocus,
        'email1': emailTextController1?.text,
        'textField6 Focus': textFieldFocusNode6?.hasFocus,
        'text15': textController15?.text,
        'textField7 Focus': textFieldFocusNode7?.hasFocus,
        'text16': textController16?.text,
        'textField8 Focus': textFieldFocusNode8?.hasFocus,
        'text17': textController17?.text,
        'gender2 Focus': genderFocusNode2?.hasFocus,
        'gender2': genderTextController2?.text,
        'textField9 Focus': textFieldFocusNode9?.hasFocus,
        'text19': textController19?.text,
        'maritalStatus2 Focus': maritalStatusFocusNode2?.hasFocus,
        'maritalStatus2': maritalStatusTextController2?.text,
        'birthCountry2 Focus': birthCountryFocusNode2?.hasFocus,
        'birthCountry2': birthCountryTextController2?.text,
        'province2 Focus': provinceFocusNode2?.hasFocus,
        'province2': provinceTextController2?.text,
        'ddi3 Focus': ddiFocusNode3?.hasFocus,
        'ddi3': ddiTextController3?.text,
        'cellphone3 Focus': cellphoneFocusNode3?.hasFocus,
        'cellphone3': cellphoneTextController3?.text,
        'ddi4 Focus': ddiFocusNode4?.hasFocus,
        'ddi4': ddiTextController4?.text,
        'cellphone4 Focus': cellphoneFocusNode4?.hasFocus,
        'cellphone4': cellphoneTextController4?.text,
        'email2 Focus': emailFocusNode2?.hasFocus,
        'email2': emailTextController2?.text,
        'textField10 Focus': textFieldFocusNode10?.hasFocus,
        'text28': textController28?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'genderList': genderList,
      'passwordVisibility': passwordVisibility,
      'dropDownValue1': dropDownValue1,
      'dropDownValueController1': dropDownValueController1,
      'dropDownValue2': dropDownValue2,
      'dropDownValueController2': dropDownValueController2,
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

  List<dynamic> genderList = [];
  void addToGenderList(dynamic item) => genderList.add(item);
  void removeFromGenderList(dynamic item) => genderList.remove(item);
  void removeAtIndexFromGenderList(int index) => genderList.removeAt(index);
  void insertAtIndexInGenderList(int index, dynamic item) =>
      genderList.insert(index, item);
  void updateGenderListAtIndex(int index, Function(dynamic) updateFn) =>
      genderList[index] = updateFn(genderList[index]);

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
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for gender widget.
  FocusNode? genderFocusNode1;
  TextEditingController? genderTextController1;
  String? Function(BuildContext, String?)? genderTextController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for maritalStatus widget.
  FocusNode? maritalStatusFocusNode1;
  TextEditingController? maritalStatusTextController1;
  String? Function(BuildContext, String?)?
      maritalStatusTextController1Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for birthCountry widget.
  FocusNode? birthCountryFocusNode1;
  TextEditingController? birthCountryTextController1;
  String? Function(BuildContext, String?)? birthCountryTextController1Validator;
  // State field(s) for province widget.
  FocusNode? provinceFocusNode1;
  TextEditingController? provinceTextController1;
  String? Function(BuildContext, String?)? provinceTextController1Validator;
  // State field(s) for DDI widget.
  FocusNode? ddiFocusNode1;
  TextEditingController? ddiTextController1;
  String? Function(BuildContext, String?)? ddiTextController1Validator;
  // State field(s) for cellphone widget.
  FocusNode? cellphoneFocusNode1;
  TextEditingController? cellphoneTextController1;
  String? Function(BuildContext, String?)? cellphoneTextController1Validator;
  // State field(s) for DDI widget.
  FocusNode? ddiFocusNode2;
  TextEditingController? ddiTextController2;
  String? Function(BuildContext, String?)? ddiTextController2Validator;
  // State field(s) for cellphone widget.
  FocusNode? cellphoneFocusNode2;
  TextEditingController? cellphoneTextController2;
  String? Function(BuildContext, String?)? cellphoneTextController2Validator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController15;
  String? Function(BuildContext, String?)? textController15Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController16;
  String? Function(BuildContext, String?)? textController16Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController17;
  String? Function(BuildContext, String?)? textController17Validator;
  // State field(s) for gender widget.
  FocusNode? genderFocusNode2;
  TextEditingController? genderTextController2;
  String? Function(BuildContext, String?)? genderTextController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode9;
  TextEditingController? textController19;
  String? Function(BuildContext, String?)? textController19Validator;
  // State field(s) for maritalStatus widget.
  FocusNode? maritalStatusFocusNode2;
  TextEditingController? maritalStatusTextController2;
  String? Function(BuildContext, String?)?
      maritalStatusTextController2Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for birthCountry widget.
  FocusNode? birthCountryFocusNode2;
  TextEditingController? birthCountryTextController2;
  String? Function(BuildContext, String?)? birthCountryTextController2Validator;
  // State field(s) for province widget.
  FocusNode? provinceFocusNode2;
  TextEditingController? provinceTextController2;
  String? Function(BuildContext, String?)? provinceTextController2Validator;
  // State field(s) for DDI widget.
  FocusNode? ddiFocusNode3;
  TextEditingController? ddiTextController3;
  String? Function(BuildContext, String?)? ddiTextController3Validator;
  // State field(s) for cellphone widget.
  FocusNode? cellphoneFocusNode3;
  TextEditingController? cellphoneTextController3;
  String? Function(BuildContext, String?)? cellphoneTextController3Validator;
  // State field(s) for DDI widget.
  FocusNode? ddiFocusNode4;
  TextEditingController? ddiTextController4;
  String? Function(BuildContext, String?)? ddiTextController4Validator;
  // State field(s) for cellphone widget.
  FocusNode? cellphoneFocusNode4;
  TextEditingController? cellphoneTextController4;
  String? Function(BuildContext, String?)? cellphoneTextController4Validator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode10;
  TextEditingController? textController28;
  String? Function(BuildContext, String?)? textController28Validator;

  @override
  void initState(BuildContext context) {
    textController1?.addListener(onUpdate);
    textController2?.addListener(onUpdate);
    textController3?.addListener(onUpdate);
    textController4?.addListener(onUpdate);
    genderTextController1?.addListener(onUpdate);
    textController6?.addListener(onUpdate);
    maritalStatusTextController1?.addListener(onUpdate);
    birthCountryTextController1?.addListener(onUpdate);
    provinceTextController1?.addListener(onUpdate);
    ddiTextController1?.addListener(onUpdate);
    cellphoneTextController1?.addListener(onUpdate);
    ddiTextController2?.addListener(onUpdate);
    cellphoneTextController2?.addListener(onUpdate);
    emailTextController1?.addListener(onUpdate);
    textController15?.addListener(onUpdate);
    textController16?.addListener(onUpdate);
    textController17?.addListener(onUpdate);
    genderTextController2?.addListener(onUpdate);
    textController19?.addListener(onUpdate);
    maritalStatusTextController2?.addListener(onUpdate);
    birthCountryTextController2?.addListener(onUpdate);
    provinceTextController2?.addListener(onUpdate);
    ddiTextController3?.addListener(onUpdate);
    cellphoneTextController3?.addListener(onUpdate);
    ddiTextController4?.addListener(onUpdate);
    cellphoneTextController4?.addListener(onUpdate);
    emailTextController2?.addListener(onUpdate);
    textController28?.addListener(onUpdate);
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    genderFocusNode1?.dispose();
    genderTextController1?.dispose();

    textFieldFocusNode5?.dispose();
    textController6?.dispose();

    maritalStatusFocusNode1?.dispose();
    maritalStatusTextController1?.dispose();

    birthCountryFocusNode1?.dispose();
    birthCountryTextController1?.dispose();

    provinceFocusNode1?.dispose();
    provinceTextController1?.dispose();

    ddiFocusNode1?.dispose();
    ddiTextController1?.dispose();

    cellphoneFocusNode1?.dispose();
    cellphoneTextController1?.dispose();

    ddiFocusNode2?.dispose();
    ddiTextController2?.dispose();

    cellphoneFocusNode2?.dispose();
    cellphoneTextController2?.dispose();

    emailFocusNode1?.dispose();
    emailTextController1?.dispose();

    textFieldFocusNode6?.dispose();
    textController15?.dispose();

    textFieldFocusNode7?.dispose();
    textController16?.dispose();

    textFieldFocusNode8?.dispose();
    textController17?.dispose();

    genderFocusNode2?.dispose();
    genderTextController2?.dispose();

    textFieldFocusNode9?.dispose();
    textController19?.dispose();

    maritalStatusFocusNode2?.dispose();
    maritalStatusTextController2?.dispose();

    birthCountryFocusNode2?.dispose();
    birthCountryTextController2?.dispose();

    provinceFocusNode2?.dispose();
    provinceTextController2?.dispose();

    ddiFocusNode3?.dispose();
    ddiTextController3?.dispose();

    cellphoneFocusNode3?.dispose();
    cellphoneTextController3?.dispose();

    ddiFocusNode4?.dispose();
    ddiTextController4?.dispose();

    cellphoneFocusNode4?.dispose();
    cellphoneTextController4?.dispose();

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();

    textFieldFocusNode10?.dispose();
    textController28?.dispose();
  }
}
