import '/components/calendario/component_card_schedule/component_card_schedule_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_week_model.dart';
export 'calendar_week_model.dart';

class CalendarWeekWidget extends StatefulWidget {
  const CalendarWeekWidget({
    super.key,
    this.weekDays,
    this.month,
    this.year,
    required this.widget,
    this.items,
    this.hoursJson,
    this.callBackCard,
    this.loading,
    this.callBackEdit,
  });

  final dynamic weekDays;
  final int? month;
  final int? year;
  final Widget Function(int? height, int? width, String idSchedule,
      dynamic item, int widhtPercentage)? widget;
  final List<dynamic>? items;
  final List<dynamic>? hoursJson;
  final Future Function(String formattedDay, String hour)? callBackCard;
  final bool? loading;
  final Future Function(dynamic selectedItem)? callBackEdit;

  @override
  State<CalendarWeekWidget> createState() => _CalendarWeekWidgetState();
}

class _CalendarWeekWidgetState extends State<CalendarWeekWidget>
    with TickerProviderStateMixin {
  late CalendarWeekModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarWeekModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).tsNeutral200,
            angle: 0.524,
          ),
        ],
      ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(0.0),
                                ),
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral100,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 16.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'gb79novy' /*  */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                            Builder(
                              builder: (context) {
                                final titleWeekDays =
                                    widget!.weekDays?.toList() ?? [];

                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(titleWeekDays.length,
                                      (titleWeekDaysIndex) {
                                    final titleWeekDaysItem =
                                        titleWeekDays[titleWeekDaysIndex];
                                    return Container(
                                      width: 220.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .tsNeutral100,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 16.0, 0.0, 16.0),
                                        child: Text(
                                          '${functions.getWeekday(getJsonField(
                                                titleWeekDaysItem,
                                                r'''$.ano''',
                                              ), getJsonField(
                                                titleWeekDaysItem,
                                                r'''$.mes''',
                                              ), getJsonField(
                                                titleWeekDaysItem,
                                                r'''$.dia''',
                                              ))}, ${getJsonField(
                                            titleWeekDaysItem,
                                            r'''$.dia''',
                                          ).toString()} ${(String var1) {
                                            return var1[0].toUpperCase() +
                                                var1.substring(1).toLowerCase();
                                          }(functions.dateMonthSpelled(getJsonField(
                                            titleWeekDaysItem,
                                            r'''$.mes''',
                                          )))}',
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tsTextDefault,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
                      ),
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final dynamicListHours =
                                          widget!.hoursJson?.toList() ?? [];

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            dynamicListHours.length,
                                            (dynamicListHoursIndex) {
                                          final dynamicListHoursItem =
                                              dynamicListHours[
                                                  dynamicListHoursIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 80.0,
                                                height: 120.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral100,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          dynamicListHoursItem,
                                                          r'''$.label''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalSm
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalSm
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalSm
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsTextDefault,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (widget!.loading ?? false) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  81.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            width: 1320.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.7,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsNeutral50,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [],
                                                ),
                                              ],
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'containerOnPageLoadAnimation']!),
                                        );
                                      } else {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  80.0, 0.0, 0.0, 0.0),
                                          child: Builder(
                                            builder: (context) {
                                              final weekDays =
                                                  widget!.weekDays?.toList() ??
                                                      [];

                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    weekDays.length,
                                                    (weekDaysIndex) {
                                                  final weekDaysItem =
                                                      weekDays[weekDaysIndex];
                                                  return Container(
                                                    width: 220.0,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsNeutral100,
                                                      ),
                                                    ),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final items = widget!
                                                                .items
                                                                ?.where((e) =>
                                                                    getJsonField(
                                                                      weekDaysItem,
                                                                      r'''$.formattedDay''',
                                                                    ) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.schedule_date''',
                                                                    ))
                                                                .toList()
                                                                ?.toList() ??
                                                            [];

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  items.length,
                                                                  (itemsIndex) {
                                                            final itemsItem =
                                                                items[
                                                                    itemsIndex];
                                                            return Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  if (!getJsonField(
                                                                    itemsItem,
                                                                    r'''$.is_empty''',
                                                                  )) {
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          valueOrDefault<double>(
                                                                            getJsonField(
                                                                              itemsItem,
                                                                              r'''$.padding''',
                                                                            ),
                                                                            0.0,
                                                                          ),
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          await widget
                                                                              .callBackEdit
                                                                              ?.call(
                                                                            itemsItem,
                                                                          );
                                                                        },
                                                                        child: Builder(builder:
                                                                            (_) {
                                                                          return widget.widget != null
                                                                              ? widget.widget!(
                                                                                  getJsonField(
                                                                                    itemsItem,
                                                                                    r'''$.height''',
                                                                                  ),
                                                                                  230,
                                                                                  getJsonField(
                                                                                    itemsItem,
                                                                                    r'''$.id''',
                                                                                  ).toString(),
                                                                                  itemsItem,
                                                                                  30,
                                                                                )
                                                                              : SizedBox.shrink();
                                                                        }),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return ComponentCardScheduleWidget(
                                                                      key: Key(
                                                                          'Keyfss_${itemsIndex}_of_${items.length}'),
                                                                      height:
                                                                          getJsonField(
                                                                        itemsItem,
                                                                        r'''$.height''',
                                                                      ),
                                                                      padding:
                                                                          getJsonField(
                                                                        itemsItem,
                                                                        r'''$.padding''',
                                                                      ),
                                                                      callBack:
                                                                          () async {
                                                                        await widget
                                                                            .callBackCard
                                                                            ?.call(
                                                                          getJsonField(
                                                                            weekDaysItem,
                                                                            r'''$.formattedDay''',
                                                                          ).toString(),
                                                                          getJsonField(
                                                                            itemsItem,
                                                                            r'''$.start_time''',
                                                                          ).toString(),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
