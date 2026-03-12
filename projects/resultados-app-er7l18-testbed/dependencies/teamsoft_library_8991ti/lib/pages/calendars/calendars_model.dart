import '/backend/schema/enums/enums.dart';
import '/components/calendario/calendar_day/calendar_day_widget.dart';
import '/components/calendario/calendar_item/calendar_item_widget.dart';
import '/components/calendario/calendar_month/calendar_month_widget.dart';
import '/components/calendario/calendar_week/calendar_week_widget.dart';
import '/components/filtros/filter_date_inline/filter_date_inline_widget.dart';
import '/components/menu/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/temp_card/temp_card_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendars_widget.dart' show CalendarsWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarsModel extends FlutterFlowModel<CalendarsWidget> {
  ///  Local state fields for this page.

  dynamic teste;

  int? toggleCalendar = 1;

  List<dynamic> jsonItems = [];
  void addToJsonItems(dynamic item) => jsonItems.add(item);
  void removeFromJsonItems(dynamic item) => jsonItems.remove(item);
  void removeAtIndexFromJsonItems(int index) => jsonItems.removeAt(index);
  void insertAtIndexInJsonItems(int index, dynamic item) =>
      jsonItems.insert(index, item);
  void updateJsonItemsAtIndex(int index, Function(dynamic) updateFn) =>
      jsonItems[index] = updateFn(jsonItems[index]);

  dynamic weekDaysCalendarWeek;

  int? monthCalendarWeek;

  int? yearCalendarWeek;

  int? dayCalendarWeek;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getWeekDaysJson] action in Calendars widget.
  dynamic? weekDayJson;
  // Model for menu component.
  MenuModel? _menuModel;
  MenuModel get menuModel => _menuModel ??= MenuModel();

  // Model for calendarMonth.
  late CalendarMonthModel calendarMonthModel;
  // Model for filterDateInline component.
  late FilterDateInlineModel filterDateInlineModel;
  // Model for calendarWeek component.
  late CalendarWeekModel calendarWeekModel;
  // Model for calendarDay component.
  late CalendarDayModel calendarDayModel;

  @override
  void initState(BuildContext context) {
    calendarMonthModel = createModel(context, () => CalendarMonthModel());
    filterDateInlineModel = createModel(context, () => FilterDateInlineModel());
    calendarWeekModel = createModel(context, () => CalendarWeekModel());
    calendarDayModel = createModel(context, () => CalendarDayModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    calendarMonthModel.dispose();
    filterDateInlineModel.dispose();
    calendarWeekModel.dispose();
    calendarDayModel.dispose();
  }
}
