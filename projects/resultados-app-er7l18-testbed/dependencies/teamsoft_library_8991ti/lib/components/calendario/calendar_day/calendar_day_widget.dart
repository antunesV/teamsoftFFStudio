import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_day_model.dart';
export 'calendar_day_model.dart';

class CalendarDayWidget extends StatefulWidget {
  const CalendarDayWidget({
    super.key,
    this.items,
    this.widget,
    this.aggregateField,
    this.callback,
    bool? hasHours,
  }) : this.hasHours = hasHours ?? true;

  final dynamic items;
  final Widget Function(double width, dynamic inforCard)? widget;
  final String? aggregateField;
  final Future Function()? callback;
  final bool hasHours;

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  late CalendarDayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarDayModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      for (int loop1Index = 0;
          loop1Index <
              getJsonField(
                widget!.items,
                r'''$.visits''',
                true,
              )!
                  .length;
          loop1Index++) {
        final currentLoop1Item = getJsonField(
          widget!.items,
          r'''$.visits''',
          true,
        )![loop1Index];
        if (!_model.lines.contains(getJsonField(
          currentLoop1Item,
          r'''$.line''',
        ))) {
          _model.addToLines(getJsonField(
            currentLoop1Item,
            r'''$.line''',
          ));
          safeSetState(() {});
        }
      }
      _model.visits = getJsonField(
        widget!.items,
        r'''$.visits''',
        true,
      )!
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
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: 1200.0,
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
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
                  Builder(
                    builder: (context) {
                      final line = getJsonField(
                        widget!.items,
                        r'''$.visits''',
                      ).toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(line.length, (lineIndex) {
                          final lineItem = line[lineIndex];
                          return Builder(
                            builder: (context) {
                              final items = getJsonField(
                                lineItem,
                                r'''$.items''',
                              ).toList();

                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(items.length, (itemsIndex) {
                                  final itemsItem = items[itemsIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        valueOrDefault<double>(
                                          getJsonField(
                                            itemsItem,
                                            r'''$.padding_start''',
                                          ),
                                          0.0,
                                        ),
                                        0.0,
                                        0.0,
                                        0.0),
                                    child: Builder(builder: (_) {
                                      return widget.widget != null
                                          ? widget.widget!(
                                              getJsonField(
                                                itemsItem,
                                                r'''$.width''',
                                              ),
                                              itemsItem,
                                            )
                                          : SizedBox.shrink();
                                    }),
                                  );
                                }),
                              );
                            },
                          );
                        }).divide(SizedBox(height: 8.0)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
