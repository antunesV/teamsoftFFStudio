import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'datepicker_model.dart';
export 'datepicker_model.dart';

class DatepickerWidget extends StatefulWidget {
  const DatepickerWidget({super.key});

  @override
  State<DatepickerWidget> createState() => _DatepickerWidgetState();
}

class _DatepickerWidgetState extends State<DatepickerWidget> {
  late DatepickerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DatepickerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tsNeutral0,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlutterFlowCalendar(
            color: FlutterFlowTheme.of(context).tsPrimaryDefault,
            iconColor: FlutterFlowTheme.of(context).tsNeutral700,
            weekFormat: false,
            weekStartsMonday: false,
            rowHeight: 58.0,
            onChange: (DateTimeRange? newSelectedDate) async {
              if (_model.calendarSelectedDay == newSelectedDate) {
                return;
              }
              _model.calendarSelectedDay = newSelectedDate;
              Navigator.pop(context, _model.calendarSelectedDay);
              safeSetState(() {});
            },
            titleStyle: FlutterFlowTheme.of(context).tsFontSemiboldXl.override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontSemiboldXl.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextDefault,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontSemiboldXl.fontStyle,
                ),
            dayOfWeekStyle: FlutterFlowTheme.of(context)
                .tsFontNormalBase
                .override(
                  font: GoogleFonts.roboto(
                    fontWeight: FlutterFlowTheme.of(context)
                        .tsFontNormalBase
                        .fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontNormalBase.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsNeutral600,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).tsFontNormalBase.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontNormalBase.fontStyle,
                ),
            dateStyle: FlutterFlowTheme.of(context).tsFontMediumBase.override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontMediumBase.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextDefault,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontMediumBase.fontStyle,
                ),
            selectedDateStyle: FlutterFlowTheme.of(context)
                .tsFontSemiboldBase
                .override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context)
                        .tsFontSemiboldBase
                        .fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextInverter,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontSemiboldBase.fontStyle,
                ),
            inactiveDateStyle: FlutterFlowTheme.of(context)
                .tsFontNormalSm
                .override(
                  font: GoogleFonts.roboto(
                    fontWeight:
                        FlutterFlowTheme.of(context).tsFontNormalSm.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontNormalSm.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsNeutral600,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).tsFontNormalSm.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontNormalSm.fontStyle,
                ),
            locale: FFLocalizations.of(context).languageCode,
          ),
        ],
      ),
    );
  }
}
