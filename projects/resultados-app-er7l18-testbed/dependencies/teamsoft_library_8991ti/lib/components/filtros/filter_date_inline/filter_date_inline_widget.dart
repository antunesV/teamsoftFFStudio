import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_date_inline_model.dart';
export 'filter_date_inline_model.dart';

class FilterDateInlineWidget extends StatefulWidget {
  const FilterDateInlineWidget({
    super.key,
    this.month,
    required this.year,
    this.executeCallback,
    required this.type,
    this.day,
    this.weekDays,
    bool? isToday,
  }) : this.isToday = isToday ?? false;

  final int? month;
  final int? year;
  final Future Function(int? month, int? year, int? day, dynamic weekDays)?
      executeCallback;
  final TypeCalendarFilter? type;
  final int? day;
  final dynamic weekDays;
  final bool isToday;

  @override
  State<FilterDateInlineWidget> createState() => _FilterDateInlineWidgetState();
}

class _FilterDateInlineWidgetState extends State<FilterDateInlineWidget> {
  late FilterDateInlineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterDateInlineModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.month = widget!.month!;
      _model.year = widget!.year!;
      _model.day = widget!.day;
      _model.weekDays = widget!.weekDays;
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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tsNeutral0,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).tsNeutral300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (widget!.type == TypeCalendarFilter.month) {
                                // Se o mês for igual a 01, então ano -1, se não ano mantem o mesmo valor
                                // Ano
                                _model.year = _model.month == 1
                                    ? (_model.year - 1)
                                    : _model.year;
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month =
                                    _model.month == 1 ? 12 : (_model.month - 1);
                                safeSetState(() {});
                              } else if (widget!.type ==
                                  TypeCalendarFilter.day) {
                                _model.returnDayJsonForwardFalse =
                                    await actions.getDayJson(
                                  _model.day!,
                                  _model.month,
                                  _model.year,
                                  false,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.returnDayJsonForwardFalse,
                                  r'''$.ano''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.returnDayJsonForwardFalse,
                                  r'''$.mes''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dia
                                _model.day = getJsonField(
                                  _model.returnDayJsonForwardFalse,
                                  r'''$.dia''',
                                );
                                safeSetState(() {});
                              } else if (widget!.type ==
                                  TypeCalendarFilter.week) {
                                _model.weekDayJson =
                                    await actions.getWeekDaysJson(
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[0].dia''',
                                        )
                                      : _model.day!,
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[0].mes''',
                                        )
                                      : _model.month,
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[0].ano''',
                                        )
                                      : _model.year,
                                  false,
                                  false,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.weekDayJson,
                                  r'''$.anoInicio''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.weekDayJson,
                                  r'''$.mesInicio''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dias da semana
                                _model.weekDays = getJsonField(
                                  _model.weekDayJson,
                                  r'''$.dias''',
                                );
                                _model.day = getJsonField(
                                  _model.weekDayJson,
                                  r'''$.dias[0].dia''',
                                );
                                safeSetState(() {});
                              } else {
                                // Ano 01 sempre
                                // Ano
                                _model.year = _model.year - 1;
                                safeSetState(() {});
                              }

                              await widget.executeCallback?.call(
                                _model.month,
                                _model.year,
                                _model.day,
                                _model.weekDays,
                              );

                              safeSetState(() {});
                            },
                            child: Icon(
                              FFIcons.kcaretLeft,
                              color: FlutterFlowTheme.of(context).tsTextDefault,
                              size: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final _datePickedDate = await showDatePicker(
                                context: context,
                                initialDate: functions.dateCreate(
                                    _model.year, _model.month, _model.day!),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .tsPrimaryDefault,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .tsTextInverter,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .tsFontNormalBase
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsTextDefault,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalBase
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalBase
                                                      .fontStyle,
                                            ),
                                    pickerBackgroundColor:
                                        FlutterFlowTheme.of(context).tsNeutral0,
                                    pickerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .tsTextDefault,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .tsPrimaryDefault,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).tsNeutral0,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .tsTextDefault,
                                    iconSize: 24.0,
                                  );
                                },
                              );

                              if (_datePickedDate != null) {
                                safeSetState(() {
                                  _model.datePicked = DateTime(
                                    _datePickedDate.year,
                                    _datePickedDate.month,
                                    _datePickedDate.day,
                                  );
                                });
                              } else if (_model.datePicked != null) {
                                safeSetState(() {
                                  _model.datePicked = functions.dateCreate(
                                      _model.year, _model.month, _model.day!);
                                });
                              }
                              _model.day =
                                  functions.dateDay(_model.datePicked!);
                              _model.year =
                                  functions.dateYear(_model.datePicked!);
                              _model.month =
                                  functions.dateMonth(_model.datePicked!);
                              safeSetState(() {});
                              if (widget!.type == TypeCalendarFilter.day) {
                                _model.returnDayJsonDatePicker =
                                    await actions.getDayJson(
                                  _model.day!,
                                  _model.month,
                                  _model.year,
                                  true,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.returnDayJsonDatePicker,
                                  r'''$.ano''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.returnDayJsonDatePicker,
                                  r'''$.mes''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dia
                                _model.day = getJsonField(
                                  _model.returnDayJsonDatePicker,
                                  r'''$.dia''',
                                );
                                safeSetState(() {});
                              } else if (widget!.type ==
                                  TypeCalendarFilter.week) {
                                _model.weekDayJsonDatePicker =
                                    await actions.getWeekDaysJson(
                                  _model.day!,
                                  _model.month,
                                  _model.year,
                                  true,
                                  false,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.weekDayJsonDatePicker,
                                  r'''$.anoInicio''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.weekDayJsonDatePicker,
                                  r'''$.mesInicio''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dias da semana
                                _model.weekDays = getJsonField(
                                  _model.weekDayJsonDatePicker,
                                  r'''$.dias''',
                                );
                                _model.day = getJsonField(
                                  _model.weekDayJsonDatePicker,
                                  r'''$.dias[0].dia''',
                                );
                                safeSetState(() {});
                              }

                              await widget.executeCallback?.call(
                                _model.month,
                                _model.year,
                                _model.day,
                                _model.weekDays,
                              );

                              safeSetState(() {});
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 140.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (widget!.type ==
                                          TypeCalendarFilter.day) {
                                        return RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  _model.day?.toString(),
                                                  '00',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'lcp4wq37' /*   */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  functions.dateMonthSpelled(
                                                      _model.month),
                                                  'Dezembro',
                                                ).substring(0, 3),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'wy8mk4xu' /* .  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: _model.year.toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'nfud80nc' /* ,  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: functions
                                                    .dateWeekdaySpelled(
                                                        functions.dateCreate(
                                                            _model.year,
                                                            _model.month,
                                                            _model.day!)),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral800,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        );
                                      } else if (widget!.type ==
                                          TypeCalendarFilter.week) {
                                        return RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  (_model.weekDays != null) &&
                                                          (widget!.day !=
                                                              _model.day)
                                                      ? getJsonField(
                                                          _model.weekDays,
                                                          r'''$[0].dia''',
                                                        ).toString()
                                                      : _model.day?.toString(),
                                                  '00',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'ul039919' /*   */,
                                                ),
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: getJsonField(
                                                          _model.weekDays,
                                                          r'''$[0].mes''',
                                                        ) !=
                                                        getJsonField(
                                                          _model.weekDays,
                                                          r'''$[6].mes''',
                                                        )
                                                    ? (valueOrDefault<String>(
                                                        functions
                                                            .dateMonthSpelled(
                                                                getJsonField(
                                                          _model.weekDays,
                                                          r'''$[0].mes''',
                                                        )),
                                                        'Dezembro',
                                                      ).substring(0, 3))
                                                    : '',
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: getJsonField(
                                                          _model.weekDays,
                                                          r'''$[0].mes''',
                                                        ) !=
                                                        getJsonField(
                                                          _model.weekDays,
                                                          r'''$[6].mes''',
                                                        )
                                                    ? ' - '
                                                    : '- ',
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    (_model.weekDays != null) &&
                                                            (widget!.day !=
                                                                _model.day)
                                                        ? getJsonField(
                                                            _model.weekDays,
                                                            r'''$[6].dia''',
                                                          ).toString()
                                                        : getJsonField(
                                                            _model.weekDays,
                                                            r'''$[6].dia''',
                                                          ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'gjnnsf9r' /*   */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: getJsonField(
                                                          _model.weekDays,
                                                          r'''$[0].mes''',
                                                        ) !=
                                                        getJsonField(
                                                          _model.weekDays,
                                                          r'''$[6].mes''',
                                                        )
                                                    ? (valueOrDefault<String>(
                                                        functions
                                                            .dateMonthSpelled(
                                                                getJsonField(
                                                          _model.weekDays,
                                                          r'''$[6].mes''',
                                                        )),
                                                        'Dezembro',
                                                      ).substring(0, 3))
                                                    : (valueOrDefault<String>(
                                                        functions
                                                            .dateMonthSpelled(
                                                                _model.month),
                                                        'Dezembro',
                                                      ).substring(0, 3)),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '8r20h3rw' /* .  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: _model.year.toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral800,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        );
                                      } else {
                                        return RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  functions.dateMonthSpelled(
                                                      _model.month),
                                                  'Dezembro',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'd9wiu9ht' /*   */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              TextSpan(
                                                text: _model.year.toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                          FlutterFlowTheme.of(
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
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral800,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (widget!.type == TypeCalendarFilter.month) {
                                // Ano
                                _model.year = _model.month == 12
                                    ? (_model.year + 1)
                                    : _model.year;
                                safeSetState(() {});
                                // Mês
                                _model.month =
                                    _model.month == 12 ? 1 : (_model.month + 1);
                                safeSetState(() {});
                              } else if (widget!.type ==
                                  TypeCalendarFilter.day) {
                                _model.returnDayJsonForward =
                                    await actions.getDayJson(
                                  _model.day!,
                                  _model.month,
                                  _model.year,
                                  true,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.returnDayJsonForward,
                                  r'''$.ano''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.returnDayJsonForward,
                                  r'''$.mes''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dia
                                _model.day = getJsonField(
                                  _model.returnDayJsonForward,
                                  r'''$.dia''',
                                );
                                safeSetState(() {});
                              } else if (widget!.type ==
                                  TypeCalendarFilter.week) {
                                _model.weekDayJsonTrue =
                                    await actions.getWeekDaysJson(
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[6].dia''',
                                        )
                                      : _model.day!,
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[6].mes''',
                                        )
                                      : _model.month,
                                  _model.weekDays != null
                                      ? getJsonField(
                                          _model.weekDays,
                                          r'''$[6].ano''',
                                        )
                                      : _model.year,
                                  true,
                                  false,
                                );
                                // Ano
                                _model.year = getJsonField(
                                  _model.weekDayJsonTrue,
                                  r'''$.anoFim''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Mês
                                _model.month = getJsonField(
                                  _model.weekDayJsonTrue,
                                  r'''$.mesFim''',
                                );
                                safeSetState(() {});
                                // Se o mês for igual a 01, então mes = 12 , se não mes - 1
                                // Dias da semana
                                _model.weekDays = getJsonField(
                                  _model.weekDayJsonTrue,
                                  r'''$.dias''',
                                );
                                _model.day = getJsonField(
                                  _model.weekDayJsonTrue,
                                  r'''$.dias[6].dia''',
                                );
                                safeSetState(() {});
                              } else {
                                // Ano 01 sempre
                                // Ano
                                _model.year = _model.year + 1;
                                safeSetState(() {});
                              }

                              await widget.executeCallback?.call(
                                _model.month,
                                _model.year,
                                _model.day,
                                _model.weekDays,
                              );

                              safeSetState(() {});
                            },
                            child: Icon(
                              FFIcons.kcaretRight,
                              color: FlutterFlowTheme.of(context).tsTextDefault,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget!.isToday)
          FFButtonWidget(
            onPressed: () async {
              _model.outputWeekDaysToday = await actions.getWeekDaysJson(
                functions.dateDay(getCurrentTimestamp),
                functions.dateMonth(getCurrentTimestamp),
                functions.dateYear(getCurrentTimestamp),
                true,
                true,
              );
              _model.month = getJsonField(
                _model.outputWeekDaysToday,
                r'''$.mesInicio''',
              );
              _model.year = getJsonField(
                _model.outputWeekDaysToday,
                r'''$.anoInicio''',
              );
              _model.day = getJsonField(
                _model.outputWeekDaysToday,
                r'''$.dias[0].dia''',
              );
              _model.weekDays = getJsonField(
                _model.outputWeekDaysToday,
                r'''$.dias''',
              );
              safeSetState(() {});
              await widget.executeCallback?.call(
                _model.month,
                _model.year,
                _model.day,
                _model.weekDays,
              );

              safeSetState(() {});
            },
            text: FFLocalizations.of(context).getText(
              '1577vr25' /* Hoje */,
            ),
            options: FFButtonOptions(
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: Color(0x00FCFF00),
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
              elevation: 0.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
