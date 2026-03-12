import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_multi_select_model.dart';
export 'input_multi_select_model.dart';

class InputMultiSelectWidget extends StatefulWidget {
  const InputMultiSelectWidget({
    super.key,
    required this.label,
    this.executeAction,
    this.icon,
    required this.list,
    String? fieldId,
    String? fieldName,
    required this.variant,
    this.width,
    double? itemSpace,
    double? paddingTop,
    bool? hasSearch,
    bool? addable,
    this.initialListSelected,
    this.selectedIcon,
    bool? isBottomSheet,
    bool? noBorder,
  })  : this.fieldId = fieldId ?? 'id',
        this.fieldName = fieldName ?? 'name',
        this.itemSpace = itemSpace ?? 0.0,
        this.paddingTop = paddingTop ?? 0.0,
        this.hasSearch = hasSearch ?? false,
        this.addable = addable ?? false,
        this.isBottomSheet = isBottomSheet ?? false,
        this.noBorder = noBorder ?? false;

  final String? label;
  final Future Function(List<dynamic>? dataMultiSelect)? executeAction;
  final Widget? icon;
  final List<dynamic>? list;
  final String fieldId;
  final String fieldName;
  final Variant? variant;
  final int? width;
  final double itemSpace;
  final double paddingTop;
  final bool hasSearch;
  final bool addable;
  final List<dynamic>? initialListSelected;
  final Widget? selectedIcon;
  final bool isBottomSheet;
  final bool noBorder;

  @override
  State<InputMultiSelectWidget> createState() => _InputMultiSelectWidgetState();
}

class _InputMultiSelectWidgetState extends State<InputMultiSelectWidget> {
  late InputMultiSelectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputMultiSelectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.listSelected =
          widget!.initialListSelected!.toList().cast<dynamic>();
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
      width: double.infinity,
      height: 40.0,
      decoration: BoxDecoration(
        color: widget!.variant == Variant.dark
            ? FlutterFlowTheme.of(context).tsNeutral900
            : FlutterFlowTheme.of(context).tsNeutral0,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widget!.noBorder
              ? Colors.transparent
              : () {
                  if ((_model.listSelected.isNotEmpty) &&
                      (widget!.variant == Variant.primary)) {
                    return FlutterFlowTheme.of(context).tsPrimaryDefault;
                  } else if ((_model.listSelected.isNotEmpty) &&
                      (widget!.variant == Variant.dark)) {
                    return FlutterFlowTheme.of(context).tsPrimaryDefault;
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
                if (_model.listSelected.isNotEmpty) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
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
                                _model.listSelected,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (widget!.icon != null) {
                                        return Container(
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
                                          child: widget!.selectedIcon != null
                                              ? widget!.selectedIcon!
                                              : widget!.icon!,
                                        );
                                      } else {
                                        return Container(
                                          width: 16.0,
                                          decoration: BoxDecoration(),
                                        );
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      '(${valueOrDefault<String>(
                                        _model.listSelected.length.toString(),
                                        '0',
                                      )})${valueOrDefault<String>(
                                        widget!.label,
                                        'MultiSelect',
                                      )}',
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
                                            color: widget!.variant ==
                                                    Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsPrimaryDefault
                                                : FlutterFlowTheme.of(context)
                                                    .tsNeutral800,
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
                                      overflow: TextOverflow.ellipsis,
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
                            _model.listSelected = [];
                            safeSetState(() {});
                            await widget.executeAction?.call(
                              _model.listSelected,
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context)
                                      .tsPrimaryDefault
                                  : FlutterFlowTheme.of(context).tsNeutral800,
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
                        _model.listSelected,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (widget!.icon != null)
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
                                  child: widget!.icon!,
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      widget!.icon != null ? 0.0 : 16.0,
                                      0.0,
                                    ),
                                    0.0,
                                    0.0,
                                    0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget!.label,
                                    'MultiSelect',
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
                                        color: () {
                                          if (widget!.variant ==
                                              Variant.neutral) {
                                            return FlutterFlowTheme.of(context)
                                                .tsNeutral800;
                                          } else if (widget!.variant ==
                                              Variant.primary) {
                                            return FlutterFlowTheme.of(context)
                                                .tsNeutral0;
                                          } else if (widget!.variant ==
                                              Variant.dark) {
                                            return FlutterFlowTheme.of(context)
                                                .tsNeutral0;
                                          } else {
                                            return FlutterFlowTheme.of(context)
                                                .tsNeutral800;
                                          }
                                        }(),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontMediumSm
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
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
                                if (widget!.variant == Variant.neutral) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral800;
                                } else if (widget!.variant == Variant.primary) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral0;
                                } else if (widget!.variant == Variant.dark) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral0;
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral800;
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
    );
  }
}
