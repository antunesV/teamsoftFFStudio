import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_date_model.dart';
export 'filter_date_model.dart';

class FilterDateWidget extends StatefulWidget {
  const FilterDateWidget({
    super.key,
    required this.label,
    required this.type,
    this.executeAction,
    bool? hasLeftIcon,
    required this.variant,
    this.initialDate,
    this.finalDate,
    this.messageError,
    this.width,
    bool? isBottomSheet,
  })  : this.hasLeftIcon = hasLeftIcon ?? true,
        this.isBottomSheet = isBottomSheet ?? false;

  final String? label;
  final TypeCalendar? type;
  final Future Function(String? initialDate, String? finalDate)? executeAction;
  final bool hasLeftIcon;
  final Variant? variant;
  final DateTime? initialDate;
  final DateTime? finalDate;
  final String? messageError;
  final double? width;
  final bool isBottomSheet;

  @override
  State<FilterDateWidget> createState() => _FilterDateWidgetState();
}

class _FilterDateWidgetState extends State<FilterDateWidget> {
  late FilterDateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterDateModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.initialDate = dateTimeFormat(
        "dd/MM/yyyy",
        widget!.initialDate,
        locale: FFLocalizations.of(context).languageCode,
      );
      _model.finalDate = dateTimeFormat(
        "dd/MM/yyyy",
        widget!.finalDate,
        locale: FFLocalizations.of(context).languageCode,
      );
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: _model.initialDate != null && _model.initialDate != ''
                ? () {
                    if (widget!.variant == Variant.dark) {
                      return FlutterFlowTheme.of(context).tsNeutral900;
                    } else if (widget!.variant != null) {
                      return (widget!.type == TypeCalendar.exact
                          ? FlutterFlowTheme.of(context).tsNeutral0
                          : FlutterFlowTheme.of(context).tsNeutral0);
                    } else {
                      return FlutterFlowTheme.of(context).tsPrimaryDefault;
                    }
                  }()
                : (widget!.variant == Variant.dark
                    ? FlutterFlowTheme.of(context).tsNeutral900
                    : (widget!.type == TypeCalendar.exact
                        ? FlutterFlowTheme.of(context).tsNeutral0
                        : FlutterFlowTheme.of(context).tsNeutral0)),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: () {
                if (widget!.messageError != null &&
                    widget!.messageError != '') {
                  return FlutterFlowTheme.of(context).tsDanger400;
                } else if (_model.initialDate != null &&
                    _model.initialDate != '') {
                  return () {
                    if (widget!.variant == Variant.dark) {
                      return FlutterFlowTheme.of(context).tsPrimaryDefault;
                    } else if (widget!.variant != null) {
                      return FlutterFlowTheme.of(context).tsNeutral200;
                    } else {
                      return FlutterFlowTheme.of(context).tsPrimaryDefault;
                    }
                  }();
                } else {
                  return (widget!.variant == Variant.dark
                      ? FlutterFlowTheme.of(context).tsNeutral800
                      : FlutterFlowTheme.of(context).tsNeutral300);
                }
              }(),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (_model.initialDate != null &&
                        _model.initialDate != '') {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await _model.updateComponent(context);
                                  safeSetState(() {});
                                  await widget.executeAction?.call(
                                    _model.initialDate,
                                    _model.finalDate,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (widget!.hasLeftIcon)
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
                                          child: Icon(
                                            FFIcons.kcalendarBlank,
                                            color: () {
                                              if (widget!.variant ==
                                                  Variant.dark) {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsPrimaryDefault;
                                              } else if (widget!.variant !=
                                                  null) {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsNeutral800;
                                              } else {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsPrimaryDefault;
                                              }
                                            }(),
                                            size: 16.0,
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            valueOrDefault<double>(
                                              widget!.hasLeftIcon ? 0.0 : 8.0,
                                              0.0,
                                            ),
                                            0.0,
                                            0.0,
                                            0.0),
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  _model.initialDate,
                                                  '01/01/2025',
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
                                                      color: widget!.variant ==
                                                              Variant.dark
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .tsPrimaryDefault
                                                          : FlutterFlowTheme.of(
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
                                                text: _model.finalDate !=
                                                            null &&
                                                        _model.finalDate != ''
                                                    ? ' - '
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
                                                      color: widget!.variant ==
                                                              Variant.dark
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .tsPrimaryDefault
                                                          : FlutterFlowTheme.of(
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
                                                text: _model.finalDate !=
                                                            null &&
                                                        _model.finalDate != ''
                                                    ? _model.finalDate!
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
                                                      color: widget!.variant ==
                                                              Variant.dark
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .tsPrimaryDefault
                                                          : FlutterFlowTheme.of(
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
                                                  color: widget!.variant ==
                                                          Variant.dark
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .tsPrimaryDefault
                                                      : FlutterFlowTheme.of(
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.initialDate = '';
                                _model.finalDate = null;
                                safeSetState(() {});
                                await widget.executeAction?.call(
                                  null,
                                  null,
                                );
                              },
                              child: Container(
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
                                child: Icon(
                                  FFIcons.kx,
                                  color: () {
                                    if (widget!.variant == Variant.dark) {
                                      return FlutterFlowTheme.of(context)
                                          .tsPrimaryDefault;
                                    } else if (widget!.variant != null) {
                                      return FlutterFlowTheme.of(context)
                                          .tsNeutral800;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tsPrimaryDefault;
                                    }
                                  }(),
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await _model.updateComponent(context);
                          safeSetState(() {});
                          await widget.executeAction?.call(
                            _model.initialDate,
                            _model.finalDate,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (widget!.hasLeftIcon)
                                      Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                        ),
                                        child: Icon(
                                          FFIcons.kcalendarBlank,
                                          color: () {
                                            if (widget!.variant ==
                                                Variant.dark) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsNeutral0;
                                            } else if (widget!.variant !=
                                                null) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsNeutral800;
                                            } else {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsPrimaryDefault;
                                            }
                                          }(),
                                          size: 16.0,
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          valueOrDefault<double>(
                                            widget!.hasLeftIcon ? 0.0 : 8.0,
                                            0.0,
                                          ),
                                          0.0,
                                          0.0,
                                          0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          widget!.label,
                                          'Date',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .tsFontMediumSm
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontMediumSm
                                                        .fontStyle,
                                              ),
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsTextInverter
                                                  : FlutterFlowTheme.of(context)
                                                      .tsTextDefault,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontMediumSm
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ],
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
                                child: Icon(
                                  FFIcons.kcaretDown,
                                  color: () {
                                    if (widget!.variant == Variant.dark) {
                                      return FlutterFlowTheme.of(context)
                                          .tsTextInverter;
                                    } else if (widget!.variant != null) {
                                      return FlutterFlowTheme.of(context)
                                          .tsNeutral800;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .tsPrimaryDefault;
                                    }
                                  }(),
                                  size: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        if (widget!.messageError != null && widget!.messageError != '')
          Text(
            FFLocalizations.of(context).getText(
              'u9xfvugh' /* Hello World */,
            ),
            style: FlutterFlowTheme.of(context).tsFontNormalXs.override(
                  font: GoogleFonts.roboto(
                    fontWeight:
                        FlutterFlowTheme.of(context).tsFontNormalXs.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontNormalXs.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsDanger400,
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).tsFontNormalXs.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontNormalXs.fontStyle,
                ),
          ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
