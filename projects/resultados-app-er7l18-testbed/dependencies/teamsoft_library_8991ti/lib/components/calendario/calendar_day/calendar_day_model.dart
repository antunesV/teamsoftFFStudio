import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'calendar_day_widget.dart' show CalendarDayWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarDayModel extends FlutterFlowModel<CalendarDayWidget> {
  ///  Local state fields for this component.

  List<int> lines = [];
  void addToLines(int item) => lines.add(item);
  void removeFromLines(int item) => lines.remove(item);
  void removeAtIndexFromLines(int index) => lines.removeAt(index);
  void insertAtIndexInLines(int index, int item) => lines.insert(index, item);
  void updateLinesAtIndex(int index, Function(int) updateFn) =>
      lines[index] = updateFn(lines[index]);

  List<dynamic> visits = [];
  void addToVisits(dynamic item) => visits.add(item);
  void removeFromVisits(dynamic item) => visits.remove(item);
  void removeAtIndexFromVisits(int index) => visits.removeAt(index);
  void insertAtIndexInVisits(int index, dynamic item) =>
      visits.insert(index, item);
  void updateVisitsAtIndex(int index, Function(dynamic) updateFn) =>
      visits[index] = updateFn(visits[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
