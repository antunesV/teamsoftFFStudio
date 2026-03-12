import '/backend/schema/enums/enums.dart';
import '/components/listagens/pagination/pagination_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'paginator_model.dart';
export 'paginator_model.dart';

class PaginatorWidget extends StatefulWidget {
  const PaginatorWidget({
    super.key,
    required this.actualPage,
    required this.totalPages,
    required this.executeActionPaginator,
    required this.totalRecords,
    required this.recordsPerPage,
    String? textRecords,
    this.variant,
    bool? isResponsive,
  })  : this.textRecords = textRecords ?? 'registros',
        this.isResponsive = isResponsive ?? false;

  final int? actualPage;
  final int? totalPages;
  final Future Function(int page)? executeActionPaginator;
  final int? totalRecords;
  final int? recordsPerPage;
  final String textRecords;
  final Variant? variant;
  final bool isResponsive;

  @override
  State<PaginatorWidget> createState() => _PaginatorWidgetState();
}

class _PaginatorWidgetState extends State<PaginatorWidget> {
  late PaginatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaginatorModel());

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
      constraints: BoxConstraints(
        maxHeight: widget!.isResponsive ? 72.0 : 1000.0,
      ),
      decoration: BoxDecoration(),
      child: Flex(
        direction: (widget!.isResponsive
                ? (MediaQuery.sizeOf(context).width >= 576.0 ? true : false)
                : true)
            ? Axis.horizontal
            : Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'th3qw96d' /* Mostrando  */,
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
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
                      TextSpan(
                        text: valueOrDefault<String>(
                          ((((widget!.actualPage!) - 1) *
                                      (widget!.recordsPerPage!)) +
                                  1)
                              .toString(),
                          '1',
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
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          '0e17wkxo' /* - */,
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
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          ((int actualPage, int recordsPerPage,
                                      int totalRecords) {
                            return ((((actualPage - 1) * recordsPerPage) + 1) +
                                        recordsPerPage -
                                        1) >
                                    totalRecords
                                ? totalRecords
                                : ((((actualPage - 1) * recordsPerPage) + 1) +
                                    recordsPerPage -
                                    1);
                          }(widget!.actualPage!, widget!.recordsPerPage!,
                                  widget!.totalRecords!))
                              .toString(),
                          '10',
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
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'j486cbh2' /*  de  */,
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
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
                      TextSpan(
                        text: valueOrDefault<String>(
                          widget!.totalRecords.toString(),
                          '25',
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
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: FFLocalizations.of(context).getText(
                          'frglr7ty' /*   */,
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
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
                      TextSpan(
                        text: valueOrDefault<String>(
                          widget!.textRecords,
                          'registros',
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontStyle,
                            ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).tsFontNormalSm.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .fontStyle,
                          ),
                          color: widget!.variant == Variant.dark
                              ? FlutterFlowTheme.of(context).tsTextInverter
                              : FlutterFlowTheme.of(context).tsTextDefault,
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
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              wrapWithModel(
                model: _model.paginationModel,
                updateCallback: () => safeSetState(() {}),
                child: PaginationWidget(
                  actualPage: widget!.actualPage!,
                  totalPages: widget!.totalPages!,
                  variant: widget!.variant != null ? widget!.variant : null,
                  executeActionPagination: (pageGo) async {
                    await widget.executeActionPaginator?.call(
                      pageGo,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
