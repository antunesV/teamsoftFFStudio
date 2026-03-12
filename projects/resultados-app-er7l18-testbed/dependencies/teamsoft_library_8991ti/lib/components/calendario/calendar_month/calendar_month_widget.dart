import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_month_model.dart';
export 'calendar_month_model.dart';

class CalendarMonthWidget extends StatefulWidget {
  const CalendarMonthWidget({
    super.key,
    required this.month,
    required this.year,
    required this.callbackDate,
    required this.calendarItem,
    this.events,
  });

  final int? month;
  final int? year;
  final Future Function(DateTime date, String? idReposition)? callbackDate;
  final Widget Function(String? title)? calendarItem;
  final dynamic events;

  @override
  State<CalendarMonthWidget> createState() => _CalendarMonthWidgetState();
}

class _CalendarMonthWidgetState extends State<CalendarMonthWidget> {
  late CalendarMonthModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarMonthModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.days = functions
          .dateCalendarDays(widget!.month!, widget!.year!)
          .toList()
          .cast<DateTime>();
      safeSetState(() {});
      _model.teste = functions
          .jsonByKey(widget!.events!, '2025-07-01')
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '3spm4x6e' /* Domingo */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'paoek1rf' /* Segunda */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'lca52bnz' /* Terça */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '6hh8yfq3' /* Quarta */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '2tz005ds' /* Quinta */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'n1f8f7bj' /* Sexta */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '57zmxq6g' /* Sabado */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsTextDefault,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final calendarDays = functions
                          .dateCalendarDays(widget!.month!, widget!.year!)
                          .toList();

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 1.0,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: calendarDays.length,
                        itemBuilder: (context, calendarDaysIndex) {
                          final calendarDaysItem =
                              calendarDays[calendarDaysIndex];
                          return Builder(
                            builder: (context) {
                              if (functions.dateMonth(calendarDaysItem) ==
                                  widget!.month) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await widget.callbackDate?.call(
                                      calendarDaysItem,
                                      '',
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 100.0,
                                    constraints: BoxConstraints(
                                      minWidth: 100.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (widget!.month ==
                                                  functions.dateMonth(
                                                      calendarDaysItem)) &&
                                              (dateTimeFormat(
                                                    "d/M/y",
                                                    calendarDaysItem,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) ==
                                                  dateTimeFormat(
                                                    "d/M/y",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ))
                                          ? FlutterFlowTheme.of(context)
                                              .tsPrimary50
                                          : FlutterFlowTheme.of(context)
                                              .tsNeutral100,
                                      borderRadius: BorderRadius.circular(0.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .tsNeutral200,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            dateTimeFormat(
                                              "dd",
                                              calendarDaysItem,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .tsFontNormalSm
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsTextDefault,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                          ),
                                          if (getJsonField(
                                                widget!.events,
                                                r'''$''',
                                              ) !=
                                              null)
                                            Expanded(
                                              child: Builder(
                                                builder: (context) {
                                                  final listEvents = functions
                                                      .jsonByKey(
                                                          widget!.events!,
                                                          dateTimeFormat(
                                                            "yyyy-MM-dd",
                                                            calendarDaysItem,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ))
                                                      .map((e) => e)
                                                      .toList();

                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                          listEvents.length,
                                                          (listEventsIndex) {
                                                        final listEventsItem =
                                                            listEvents[
                                                                listEventsIndex];
                                                        return InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await widget
                                                                .callbackDate
                                                                ?.call(
                                                              calendarDaysItem,
                                                              getJsonField(
                                                                listEventsItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                            );
                                                          },
                                                          child: Builder(
                                                              builder: (_) {
                                                            return widget
                                                                        .calendarItem !=
                                                                    null
                                                                ? widget
                                                                    .calendarItem!(
                                                                    '${getJsonField(
                                                                      listEventsItem,
                                                                      r'''$.flag_name''',
                                                                    ).toString()} - ${getJsonField(
                                                                      listEventsItem,
                                                                      r'''$.address_neighborhood''',
                                                                    ).toString()}',
                                                                  )
                                                                : SizedBox
                                                                    .shrink();
                                                          }),
                                                        );
                                                      }).divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: (widget!.month ==
                                                functions.dateMonth(
                                                    calendarDaysItem)) &&
                                            (dateTimeFormat(
                                                  "d/M/y",
                                                  calendarDaysItem,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ) ==
                                                dateTimeFormat(
                                                  "d/M/y",
                                                  getCurrentTimestamp,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ))
                                        ? FlutterFlowTheme.of(context)
                                            .tsPrimary50
                                        : FlutterFlowTheme.of(context)
                                            .tsNeutral100,
                                    borderRadius: BorderRadius.circular(0.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral200,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .tsNeutral0,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'packages/teamsoft_library_8991ti/assets/images/empty.png',
                                          ).image,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
