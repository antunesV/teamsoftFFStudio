import '/flutter_flow/action_registry.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'select_bottom_sheet_widget.dart' show SelectBottomSheetWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectBottomSheetModel extends FlutterFlowModel<SelectBottomSheetWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
        'height': widget.height,
        'bottomsheetTitle': widget.bottomsheetTitle,
        'hasSearch': widget.hasSearch,
        'searchText': widget.searchText,
        'jsonData': widget.jsonData,
        'listviewItemSpacing': widget.listviewItemSpacing,
        'listviewPadding': widget.listviewPadding,
        'searchParameters': widget.searchParameters,
        'countryList': widget.countryList,
        'checkbox': widget.checkbox,
        'selectedOptionAction': widget.selectedOptionAction,
      },
      'Action Outputs': globalPageDataRegistry['SelectBottomSheetModel'] ?? {},
      'Dados de Widget': {
        'search Focus': searchFocusNode?.hasFocus,
        'search': searchTextController?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'checkboxValueMap': checkboxValueMap,
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






  ///  State fields for stateful widgets in this component.

  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {
    searchTextController?.addListener(onUpdate);}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
