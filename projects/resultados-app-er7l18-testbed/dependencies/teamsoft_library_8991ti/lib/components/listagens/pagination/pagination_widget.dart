import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pagination_model.dart';
export 'pagination_model.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    super.key,
    required this.actualPage,
    required this.totalPages,
    required this.executeActionPagination,
    this.variant,
  });

  final int? actualPage;
  final int? totalPages;
  final Future Function(int pageGo)? executeActionPagination;
  final Variant? variant;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late PaginationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaginationModel());

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
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      disabledIconColor:
                          FlutterFlowTheme.of(context).tsNeutral700,
                      icon: Icon(
                        FFIcons.kcaretLeft,
                        color: widget!.variant == Variant.dark
                            ? FlutterFlowTheme.of(context).tsTextInverter
                            : FlutterFlowTheme.of(context).tsTextDefault,
                        size: 16.0,
                      ),
                      onPressed: (widget!.actualPage == 1)
                          ? null
                          : () async {
                              if (widget!.actualPage != 1) {
                                await widget.executeActionPagination?.call(
                                  (widget!.actualPage!) - 1,
                                );
                              }
                            },
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        await widget.executeActionPagination?.call(
                          1,
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'ajt38bo8' /* 1 */,
                      ),
                      options: FFButtonOptions(
                        width: 32.0,
                        height: 32.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: valueOrDefault<Color>(
                          widget!.actualPage == 1
                              ? FlutterFlowTheme.of(context).tsPrimaryDefault
                              : Colors.transparent,
                          Colors.transparent,
                        ),
                        textStyle: FlutterFlowTheme.of(context)
                            .tsFontSemiboldXs
                            .override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                              color: valueOrDefault<Color>(
                                widget!.variant == Variant.dark
                                    ? valueOrDefault<Color>(
                                        widget!.actualPage == 1
                                            ? FlutterFlowTheme.of(context)
                                                .tsTextDefault
                                            : FlutterFlowTheme.of(context)
                                                .tsTextInverter,
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                      )
                                    : valueOrDefault<Color>(
                                        widget!.actualPage == 1
                                            ? FlutterFlowTheme.of(context)
                                                .tsTextInverter
                                            : FlutterFlowTheme.of(context)
                                                .tsTextDefault,
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                FlutterFlowTheme.of(context).primaryText,
                              ),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldXs
                                  .fontStyle,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    if ((widget!.actualPage! >= 4) &&
                        (widget!.totalPages! >= 6))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'fk1m83ji' /* ... */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .tsFontSemiboldSm
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldSm
                                      .fontStyle,
                                ),
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context)
                                        .tsTextInverter
                                    : FlutterFlowTheme.of(context)
                                        .tsTextDefault,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldSm
                                    .fontStyle,
                              ),
                        ),
                      ),
                    if (widget!.totalPages! > 1)
                      FFButtonWidget(
                        onPressed: () async {
                          await widget.executeActionPagination?.call(
                            valueOrDefault<int>(
                              () {
                                if ((widget!.actualPage! <= 3) ||
                                    (widget!.totalPages! <= 5)) {
                                  return 2;
                                } else if (widget!.actualPage! >
                                    ((widget!.totalPages!) - 2)) {
                                  return ((widget!.totalPages!) - 3);
                                } else {
                                  return ((widget!.actualPage!) - 1);
                                }
                              }(),
                              4,
                            ),
                          );
                        },
                        text: valueOrDefault<String>(
                          () {
                            if ((widget!.actualPage! <= 3) ||
                                (widget!.totalPages! <= 5)) {
                              return '2';
                            } else if (widget!.actualPage! >
                                ((widget!.totalPages!) - 2)) {
                              return ((widget!.totalPages!) - 3).toString();
                            } else {
                              return ((widget!.actualPage!) - 1).toString();
                            }
                          }(),
                          '4',
                        ),
                        options: FFButtonOptions(
                          width: 32.0,
                          height: 32.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: widget!.actualPage ==
                                  valueOrDefault<int>(
                                    () {
                                      if ((widget!.actualPage! <= 3) ||
                                          (widget!.totalPages! <= 5)) {
                                        return 2;
                                      } else if (widget!.actualPage! >
                                          ((widget!.totalPages!) - 2)) {
                                        return ((widget!.totalPages!) - 3);
                                      } else {
                                        return ((widget!.actualPage!) - 1);
                                      }
                                    }(),
                                    4,
                                  )
                              ? FlutterFlowTheme.of(context).tsPrimaryDefault
                              : Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldXs
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldXs
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.variant == Variant.dark
                                      ? valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 2;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            3);
                                                      } else {
                                                        return ((widget!
                                                                .actualPage!) -
                                                            1);
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextDefault
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextInverter,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        )
                                      : valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 2;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            3);
                                                      } else {
                                                        return ((widget!
                                                                .actualPage!) -
                                                            1);
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextInverter
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  FlutterFlowTheme.of(context).secondaryText,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    if (widget!.totalPages! > 2)
                      FFButtonWidget(
                        onPressed: () async {
                          await widget.executeActionPagination?.call(
                            valueOrDefault<int>(
                              () {
                                if ((widget!.actualPage! <= 3) ||
                                    (widget!.totalPages! <= 5)) {
                                  return 3;
                                } else if (widget!.actualPage! >
                                    ((widget!.totalPages!) - 2)) {
                                  return ((widget!.totalPages!) - 2);
                                } else {
                                  return widget!.actualPage;
                                }
                              }(),
                              4,
                            ),
                          );
                        },
                        text: valueOrDefault<String>(
                          () {
                            if ((widget!.actualPage! <= 3) ||
                                (widget!.totalPages! <= 5)) {
                              return '3';
                            } else if (widget!.actualPage! >
                                ((widget!.totalPages!) - 2)) {
                              return ((widget!.totalPages!) - 2).toString();
                            } else {
                              return widget!.actualPage?.toString();
                            }
                          }(),
                          '4',
                        ),
                        options: FFButtonOptions(
                          width: 32.0,
                          height: 32.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: widget!.actualPage ==
                                  valueOrDefault<int>(
                                    () {
                                      if ((widget!.actualPage! <= 3) ||
                                          (widget!.totalPages! <= 5)) {
                                        return 3;
                                      } else if (widget!.actualPage! >
                                          ((widget!.totalPages!) - 2)) {
                                        return ((widget!.totalPages!) - 2);
                                      } else {
                                        return widget!.actualPage;
                                      }
                                    }(),
                                    4,
                                  )
                              ? FlutterFlowTheme.of(context).tsPrimaryDefault
                              : Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldXs
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldXs
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.variant == Variant.dark
                                      ? valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 3;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            2);
                                                      } else {
                                                        return widget!
                                                            .actualPage;
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextDefault
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextInverter,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        )
                                      : valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 3;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            3);
                                                      } else {
                                                        return ((widget!
                                                                .actualPage!) -
                                                            1);
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextInverter
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  FlutterFlowTheme.of(context).secondaryText,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    if (widget!.totalPages! > 3)
                      FFButtonWidget(
                        onPressed: () async {
                          await widget.executeActionPagination?.call(
                            valueOrDefault<int>(
                              () {
                                if ((widget!.actualPage! <= 3) ||
                                    (widget!.totalPages! <= 5)) {
                                  return 4;
                                } else if (widget!.actualPage! >
                                    ((widget!.totalPages!) - 2)) {
                                  return ((widget!.totalPages!) - 1);
                                } else {
                                  return ((widget!.actualPage!) + 1);
                                }
                              }(),
                              4,
                            ),
                          );
                        },
                        text: valueOrDefault<String>(
                          () {
                            if ((widget!.actualPage! <= 3) ||
                                (widget!.totalPages! <= 5)) {
                              return '4';
                            } else if (widget!.actualPage! >
                                ((widget!.totalPages!) - 2)) {
                              return ((widget!.totalPages!) - 1).toString();
                            } else {
                              return ((widget!.actualPage!) + 1).toString();
                            }
                          }(),
                          '4',
                        ),
                        options: FFButtonOptions(
                          width: 32.0,
                          height: 32.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: widget!.actualPage ==
                                  valueOrDefault<int>(
                                    () {
                                      if ((widget!.actualPage! <= 3) ||
                                          (widget!.totalPages! <= 5)) {
                                        return 4;
                                      } else if (widget!.actualPage! >
                                          ((widget!.totalPages!) - 2)) {
                                        return ((widget!.totalPages!) - 1);
                                      } else {
                                        return ((widget!.actualPage!) + 1);
                                      }
                                    }(),
                                    4,
                                  )
                              ? FlutterFlowTheme.of(context).tsPrimaryDefault
                              : Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldXs
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldXs
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.variant == Variant.dark
                                      ? valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 4;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            3);
                                                      } else {
                                                        return ((widget!
                                                                .actualPage!) -
                                                            1);
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextDefault
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextInverter,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        )
                                      : valueOrDefault<Color>(
                                          widget!.actualPage ==
                                                  valueOrDefault<int>(
                                                    () {
                                                      if ((widget!.actualPage! <=
                                                              3) ||
                                                          (widget!.totalPages! <=
                                                              5)) {
                                                        return 2;
                                                      } else if (widget!
                                                              .actualPage! >
                                                          ((widget!
                                                                  .totalPages!) -
                                                              2)) {
                                                        return ((widget!
                                                                .totalPages!) -
                                                            3);
                                                      } else {
                                                        return ((widget!
                                                                .actualPage!) -
                                                            1);
                                                      }
                                                    }(),
                                                    4,
                                                  )
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextInverter
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  FlutterFlowTheme.of(context).secondaryText,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    if ((widget!.actualPage! < ((widget!.totalPages!) - 2)) &&
                        (widget!.totalPages! > 5))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '86acymmf' /* ... */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .tsFontSemiboldSm
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldSm
                                      .fontStyle,
                                ),
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context)
                                        .tsTextInverter
                                    : FlutterFlowTheme.of(context)
                                        .tsTextDefault,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldSm
                                    .fontStyle,
                              ),
                        ),
                      ),
                    if (widget!.totalPages! > 4)
                      FFButtonWidget(
                        onPressed: () async {
                          await widget.executeActionPagination?.call(
                            valueOrDefault<int>(
                              widget!.totalPages,
                              7,
                            ),
                          );
                        },
                        text: valueOrDefault<String>(
                          widget!.totalPages?.toString(),
                          '7',
                        ),
                        options: FFButtonOptions(
                          width: 32.0,
                          height: 32.0,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: widget!.actualPage == widget!.totalPages
                              ? FlutterFlowTheme.of(context).tsPrimaryDefault
                              : Colors.transparent,
                          textStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldXs
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldXs
                                      .fontStyle,
                                ),
                                color: widget!.variant == Variant.dark
                                    ? (widget!.actualPage == widget!.totalPages
                                        ? FlutterFlowTheme.of(context)
                                            .tsTextDefault
                                        : FlutterFlowTheme.of(context)
                                            .tsTextInverter)
                                    : (widget!.actualPage == widget!.totalPages
                                        ? FlutterFlowTheme.of(context)
                                            .tsTextInverter
                                        : FlutterFlowTheme.of(context)
                                            .tsTextDefault),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      disabledIconColor:
                          FlutterFlowTheme.of(context).tsNeutral700,
                      icon: Icon(
                        FFIcons.kcaretRight,
                        color: widget!.variant == Variant.dark
                            ? FlutterFlowTheme.of(context).tsTextInverter
                            : FlutterFlowTheme.of(context).tsTextDefault,
                        size: 16.0,
                      ),
                      onPressed: (widget!.actualPage == widget!.totalPages)
                          ? null
                          : () async {
                              if (widget!.actualPage != widget!.totalPages) {
                                await widget.executeActionPagination?.call(
                                  (widget!.actualPage!) + 1,
                                );
                              }
                            },
                    ),
                  ].divide(SizedBox(width: 4.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
