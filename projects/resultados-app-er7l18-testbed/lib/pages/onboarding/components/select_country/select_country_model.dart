import '/flutter_flow/action_registry.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:teamsoft_library_8991ti/app_state.dart'
    as teamsoft_library_8991ti_app_state;
import 'select_country_widget.dart' show SelectCountryWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectCountryModel extends FlutterFlowModel<SelectCountryWidget> {
  // TS_START_TOMAP
  @override
  Map<String, dynamic> ts_toMap() {
    return {
      'parametros de página': {
        'selectedCountry': widget.selectedCountry,
      },
      'Action Outputs': globalPageDataRegistry['SelectCountryModel'] ?? {},
      'Dados de Widget': {
        'textField Focus': textFieldFocusNode?.hasFocus,
        'text': textController?.text,
      },
      'Resposta de ações': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'actionOutputRegistry': actionOutputRegistry,
      'items': items,
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






  ///  Local state fields for this component.

  List<dynamic> items = [];
  void addToItems(dynamic item) => items.add(item);
  void removeFromItems(dynamic item) => items.remove(item);
  void removeAtIndexFromItems(int index) => items.removeAt(index);
  void insertAtIndexInItems(int index, dynamic item) =>
      items.insert(index, item);
  void updateItemsAtIndex(int index, Function(dynamic) updateFn) =>
      items[index] = updateFn(items[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    textController?.addListener(onUpdate);}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
