import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'filter_date_inline_widget.dart' show FilterDateInlineWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterDateInlineModel extends FlutterFlowModel<FilterDateInlineWidget> {
  ///  Local state fields for this component.

  int month = 2;

  int year = 2025;

  int? day;

  dynamic weekDays;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getDayJson] action in Icon widget.
  dynamic? returnDayJsonForwardFalse;
  // Stores action output result for [Custom Action - getWeekDaysJson] action in Icon widget.
  dynamic? weekDayJson;
  DateTime? datePicked;
  // Stores action output result for [Custom Action - getDayJson] action in Container widget.
  dynamic? returnDayJsonDatePicker;
  // Stores action output result for [Custom Action - getWeekDaysJson] action in Container widget.
  dynamic? weekDayJsonDatePicker;
  // Stores action output result for [Custom Action - getDayJson] action in Icon widget.
  dynamic? returnDayJsonForward;
  // Stores action output result for [Custom Action - getWeekDaysJson] action in Icon widget.
  dynamic? weekDayJsonTrue;
  // Stores action output result for [Custom Action - getWeekDaysJson] action in Button widget.
  dynamic? outputWeekDaysToday;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
