import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_value_model.dart';
export 'filter_value_model.dart';

class FilterValueWidget extends StatefulWidget {
  const FilterValueWidget({
    super.key,
    required this.label,
    required this.type,
    this.executeAction,
    bool? hasLeftIcon,
    required this.variant,
  }) : this.hasLeftIcon = hasLeftIcon ?? true;

  final String? label;
  final TypeCalendar? type;
  final Future Function(String? initialValue, String? finalValue)?
      executeAction;
  final bool hasLeftIcon;
  final Variant? variant;

  @override
  State<FilterValueWidget> createState() => _FilterValueWidgetState();
}

class _FilterValueWidgetState extends State<FilterValueWidget> {
  late FilterValueModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterValueModel());

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
      height: 40.0,
      decoration: BoxDecoration(
        color: _model.initialValue != null && _model.initialValue != ''
            ? (widget!.variant != null
                ? FlutterFlowTheme.of(context).tsNeutral200
                : FlutterFlowTheme.of(context).tsPrimaryDefault)
            : FlutterFlowTheme.of(context).tsNeutral50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: _model.initialValue != null && _model.initialValue != ''
              ? (widget!.variant != null
                  ? FlutterFlowTheme.of(context).tsNeutral200
                  : FlutterFlowTheme.of(context).tsPrimaryDefault)
              : FlutterFlowTheme.of(context).tsNeutral300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                if (_model.initialValue != null && _model.initialValue != '') {
                  return Container(
                    decoration: BoxDecoration(),
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
                                _model.initialValue,
                                _model.finalValue,
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
                                        FFIcons.kmoney,
                                        color: widget!.variant != null
                                            ? FlutterFlowTheme.of(context)
                                                .tsNeutral800
                                            : FlutterFlowTheme.of(context)
                                                .tsPrimaryDefault,
                                        size: 16.0,
                                      ),
                                    ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          valueOrDefault<double>(
                                            widget!.hasLeftIcon == true
                                                ? 0.0
                                                : 16.0,
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
                                                _model.initialValue,
                                                'R\$',
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
                                                    color: widget!.variant !=
                                                            null
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsPrimaryDefault,
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
                                              text: _model.finalValue != null &&
                                                      _model.finalValue != ''
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
                                                    color: widget!.variant !=
                                                            null
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsPrimaryDefault,
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
                                                _model.finalValue != null &&
                                                        _model.finalValue != ''
                                                    ? _model.finalValue
                                                    : '',
                                                'R\$',
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
                                                    color: widget!.variant !=
                                                            null
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsPrimaryDefault,
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
                                              .tsFontMediumSm
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontMediumSm
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                            _model.initialValue = '';
                            _model.finalValue = null;
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
                              color: widget!.variant != null
                                  ? FlutterFlowTheme.of(context).tsNeutral800
                                  : FlutterFlowTheme.of(context)
                                      .tsPrimaryDefault,
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
                        _model.initialValue,
                        _model.finalValue,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
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
                                        color: widget!.variant != null
                                            ? FlutterFlowTheme.of(context)
                                                .tsNeutral800
                                            : FlutterFlowTheme.of(context)
                                                .tsPrimaryDefault,
                                        size: 16.0,
                                      ),
                                    ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          valueOrDefault<double>(
                                            widget!.hasLeftIcon ? 0.0 : 16.0,
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
                                        textAlign: TextAlign.start,
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
                                  ),
                                ],
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
                            child: Icon(
                              FFIcons.kcaretDown,
                              color: widget!.variant != null
                                  ? FlutterFlowTheme.of(context).tsNeutral800
                                  : FlutterFlowTheme.of(context)
                                      .tsPrimaryDefault,
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
    );
  }
}
