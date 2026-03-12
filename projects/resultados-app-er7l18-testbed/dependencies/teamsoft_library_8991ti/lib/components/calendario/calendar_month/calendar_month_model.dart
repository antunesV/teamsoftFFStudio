import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendar_month_widget.dart' show CalendarMonthWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarMonthModel extends FlutterFlowModel<CalendarMonthWidget> {
  ///  Local state fields for this component.

  List<DateTime> days = [];
  void addToDays(DateTime item) => days.add(item);
  void removeFromDays(DateTime item) => days.remove(item);
  void removeAtIndexFromDays(int index) => days.removeAt(index);
  void insertAtIndexInDays(int index, DateTime item) =>
      days.insert(index, item);
  void updateDaysAtIndex(int index, Function(DateTime) updateFn) =>
      days[index] = updateFn(days[index]);

  List<dynamic> teste = [];
  void addToTeste(dynamic item) => teste.add(item);
  void removeFromTeste(dynamic item) => teste.remove(item);
  void removeAtIndexFromTeste(int index) => teste.removeAt(index);
  void insertAtIndexInTeste(int index, dynamic item) =>
      teste.insert(index, item);
  void updateTesteAtIndex(int index, Function(dynamic) updateFn) =>
      teste[index] = updateFn(teste[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
