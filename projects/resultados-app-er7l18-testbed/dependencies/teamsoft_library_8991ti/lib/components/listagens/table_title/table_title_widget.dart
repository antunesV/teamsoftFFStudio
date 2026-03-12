import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'table_title_model.dart';
export 'table_title_model.dart';

class TableTitleWidget extends StatefulWidget {
  const TableTitleWidget({
    super.key,
    String? label,
    required this.field,
    this.defaultAscending,
    this.actualOrderBy,
    this.executeAction,
    this.variant,
    this.tooltipText,
  }) : this.label = label ?? 'Label';

  final String label;
  final String? field;
  final bool? defaultAscending;
  final String? actualOrderBy;
  final Future Function(String order, bool? ascending)? executeAction;
  final Variant? variant;
  final String? tooltipText;

  @override
  State<TableTitleWidget> createState() => _TableTitleWidgetState();
}

class _TableTitleWidgetState extends State<TableTitleWidget> {
  late TableTitleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TableTitleModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ascending = widget!.defaultAscending;
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
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget!.field != null && widget!.field != '') {
          if (_model.ascending == true) {
            _model.ascending = false;
            safeSetState(() {});
          } else if (_model.ascending == false) {
            _model.ascending = null;
            safeSetState(() {});
          } else {
            _model.ascending = true;
            safeSetState(() {});
          }

          await widget.executeAction?.call(
            widget!.field!,
            _model.ascending,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Builder(
                builder: (context) {
                  if (widget!.tooltipText != null &&
                      widget!.tooltipText != '') {
                    return AlignedTooltip(
                      content: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          widget!.label,
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
                      offset: 4.0,
                      preferredDirection: AxisDirection.down,
                      borderRadius: BorderRadius.circular(8.0),
                      backgroundColor: widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsNeutral950
                          : FlutterFlowTheme.of(context).tsNeutral0,
                      elevation: 4.0,
                      tailBaseWidth: 24.0,
                      tailLength: 12.0,
                      waitDuration: Duration(milliseconds: 100),
                      showDuration: Duration(milliseconds: 100),
                      triggerMode: TooltipTriggerMode.tap,
                      child: Text(
                        widget!.label,
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  } else {
                    return Text(
                      widget!.label,
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
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                },
              ),
            ),
            if ((_model.ascending == null) ||
                (widget!.actualOrderBy != widget!.field))
              Icon(
                FFIcons.kcaretUpDown,
                color: widget!.variant == Variant.dark
                    ? FlutterFlowTheme.of(context).tsTextInverter
                    : FlutterFlowTheme.of(context).tsTextDefault,
                size: 16.0,
              ),
            if ((_model.ascending == true) &&
                (widget!.actualOrderBy == widget!.field))
              Icon(
                FFIcons.kcaretUp,
                color: widget!.variant == Variant.dark
                    ? FlutterFlowTheme.of(context).tsTextInverter
                    : FlutterFlowTheme.of(context).tsTextDefault,
                size: 16.0,
              ),
            if ((_model.ascending == false) &&
                (widget!.actualOrderBy == widget!.field))
              Icon(
                FFIcons.kcaretDown,
                color: widget!.variant == Variant.dark
                    ? FlutterFlowTheme.of(context).tsTextInverter
                    : FlutterFlowTheme.of(context).tsTextDefault,
                size: 16.0,
              ),
          ],
        ),
      ),
    );
  }
}
