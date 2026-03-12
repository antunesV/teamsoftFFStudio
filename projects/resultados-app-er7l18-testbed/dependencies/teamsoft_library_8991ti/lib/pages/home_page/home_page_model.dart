import '/backend/schema/enums/enums.dart';
import '/components/calendario/calendar_item/calendar_item_widget.dart';
import '/components/calendario/calendar_month/calendar_month_widget.dart';
import '/components/filtros/filter_date/filter_date_widget.dart';
import '/components/filtros/filter_date_inline/filter_date_inline_widget.dart';
import '/components/filtros/filter_value/filter_value_widget.dart';
import '/components/inputs/input_field_single_select/input_field_single_select_widget.dart';
import '/components/inputs/input_multi_select/input_multi_select_widget.dart';
import '/components/inputs/input_number/input_number_widget.dart';
import '/components/inputs/input_single_select/input_single_select_widget.dart';
import '/components/menu/horizontal/menu_horizontal/menu_horizontal_widget.dart';
import '/components/menu/menu/menu_widget.dart';
import '/components/toast/toast/toast_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  dynamic teste;

  ///  State fields for stateful widgets in this page.

  // Model for menu component.
  MenuModel? _menuModel;
  MenuModel get menuModel => _menuModel ??= MenuModel();

  // Model for filterDate component.
  late FilterDateModel filterDateModel;
  // Model for inputMultiSelect component.
  late InputMultiSelectModel inputMultiSelectModel;
  // Model for filterDateInline.
  late FilterDateInlineModel filterDateInlineModel;
  // Model for filterValue component.
  late FilterValueModel filterValueModel;
  // Model for inputSingleSelect component.
  late InputSingleSelectModel inputSingleSelectModel1;
  // Model for inputSingleSelect component.
  late InputSingleSelectModel inputSingleSelectModel2;
  // Model for inputNumber component.
  late InputNumberModel inputNumberModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - validateCpfCnpj] action in Button widget.
  bool? outputcpf;
  // Stores action output result for [Custom Action - validateCpfCnpj] action in Button widget.
  bool? outputcnpj;
  // Stores action output result for [Custom Action - validateCpfCnpj] action in Button widget.
  bool? outputambos;
  // Model for inputFieldSingleSelect component.
  late InputFieldSingleSelectModel inputFieldSingleSelectModel;
  // Model for calendarMonth.
  late CalendarMonthModel calendarMonthModel;
  // Model for menuHorizontal component.
  late MenuHorizontalModel menuHorizontalModel;

  @override
  void initState(BuildContext context) {
    filterDateModel = createModel(context, () => FilterDateModel());
    inputMultiSelectModel = createModel(context, () => InputMultiSelectModel());
    filterDateInlineModel = createModel(context, () => FilterDateInlineModel());
    filterValueModel = createModel(context, () => FilterValueModel());
    inputSingleSelectModel1 =
        createModel(context, () => InputSingleSelectModel());
    inputSingleSelectModel2 =
        createModel(context, () => InputSingleSelectModel());
    inputNumberModel = createModel(context, () => InputNumberModel());
    inputFieldSingleSelectModel =
        createModel(context, () => InputFieldSingleSelectModel());
    calendarMonthModel = createModel(context, () => CalendarMonthModel());
    menuHorizontalModel = createModel(context, () => MenuHorizontalModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    filterDateModel.dispose();
    inputMultiSelectModel.dispose();
    filterDateInlineModel.dispose();
    filterValueModel.dispose();
    inputSingleSelectModel1.dispose();
    inputSingleSelectModel2.dispose();
    inputNumberModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    inputFieldSingleSelectModel.dispose();
    calendarMonthModel.dispose();
    menuHorizontalModel.dispose();
  }
}
