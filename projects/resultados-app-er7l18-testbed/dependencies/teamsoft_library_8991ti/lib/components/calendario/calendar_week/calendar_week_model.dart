import '/components/calendario/component_card_schedule/component_card_schedule_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendar_week_widget.dart' show CalendarWeekWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarWeekModel extends FlutterFlowModel<CalendarWeekWidget> {
  ///  Local state fields for this component.

  List<dynamic> hoursColumn = [];
  void addToHoursColumn(dynamic item) => hoursColumn.add(item);
  void removeFromHoursColumn(dynamic item) => hoursColumn.remove(item);
  void removeAtIndexFromHoursColumn(int index) => hoursColumn.removeAt(index);
  void insertAtIndexInHoursColumn(int index, dynamic item) =>
      hoursColumn.insert(index, item);
  void updateHoursColumnAtIndex(int index, Function(dynamic) updateFn) =>
      hoursColumn[index] = updateFn(hoursColumn[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
