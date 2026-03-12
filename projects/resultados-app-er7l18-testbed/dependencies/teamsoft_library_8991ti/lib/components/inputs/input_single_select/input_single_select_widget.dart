import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_single_select_model.dart';
export 'input_single_select_model.dart';

class InputSingleSelectWidget extends StatefulWidget {
  const InputSingleSelectWidget({
    super.key,
    required this.label,
    this.executeAction,
    this.icon,
    required this.list,
    String? fieldId,
    String? fieldName,
    required this.variant,
    bool? styleOnSelected,
    bool? hasError,
    bool? hasSearch,
    bool? unlink,
    this.fieldDescription,
    this.fieldImage,
    this.width,
    this.initialSelected,
    this.insideHeight,
    double? itemSpace,
    double? paddingTop,
    bool? addable,
    bool? isBottomSheet,
    bool? noBorder,
    this.maxCharacters,
    String? textUnlink,
    this.selectedIcon,
    bool? hasTitle,
    this.titleText,
    this.colorText,
    bool? unselectable,
  })  : this.fieldId = fieldId ?? 'id',
        this.fieldName = fieldName ?? 'name',
        this.styleOnSelected = styleOnSelected ?? false,
        this.hasError = hasError ?? false,
        this.hasSearch = hasSearch ?? false,
        this.unlink = unlink ?? false,
        this.itemSpace = itemSpace ?? 0.0,
        this.paddingTop = paddingTop ?? 0.0,
        this.addable = addable ?? false,
        this.isBottomSheet = isBottomSheet ?? false,
        this.noBorder = noBorder ?? false,
        this.textUnlink = textUnlink ?? 'Desvincular',
        this.hasTitle = hasTitle ?? false,
        this.unselectable = unselectable ?? false;

  final String? label;
  final Future Function(dynamic dataSingleSelect)? executeAction;
  final Widget? icon;
  final List<dynamic>? list;
  final String fieldId;
  final String fieldName;
  final Variant? variant;
  final bool styleOnSelected;
  final bool hasError;
  final bool hasSearch;
  final bool unlink;
  final String? fieldDescription;
  final String? fieldImage;
  final int? width;
  final dynamic initialSelected;
  final int? insideHeight;
  final double itemSpace;
  final double paddingTop;
  final bool addable;
  final bool isBottomSheet;
  final bool noBorder;
  final int? maxCharacters;
  final String textUnlink;
  final Widget? selectedIcon;
  final bool hasTitle;
  final String? titleText;
  final Color? colorText;
  final bool unselectable;

  @override
  State<InputSingleSelectWidget> createState() =>
      _InputSingleSelectWidgetState();
}

class _InputSingleSelectWidgetState extends State<InputSingleSelectWidget> {
  late InputSingleSelectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputSingleSelectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.initialSelected != null) {
        _model.listSelected = widget!.initialSelected;
        safeSetState(() {});
      }
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
      height: 40.0,
      decoration: BoxDecoration(
        color: widget!.unselectable
            ? () {
                if (widget!.styleOnSelected) {
                  return (_model.listSelected != null
                      ? (widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsNeutral900
                          : FlutterFlowTheme.of(context).tsNeutral200)
                      : (widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsNeutral900
                          : FlutterFlowTheme.of(context).tsNeutral50));
                } else if (widget!.variant == Variant.primary) {
                  return FlutterFlowTheme.of(context).tsNeutral100;
                } else if (widget!.variant == Variant.dark) {
                  return FlutterFlowTheme.of(context).tsNeutral900;
                } else if (widget!.variant == Variant.neutral) {
                  return FlutterFlowTheme.of(context).tsNeutral100;
                } else {
                  return Color(0x00000000);
                }
              }()
            : () {
                if (widget!.styleOnSelected) {
                  return (_model.listSelected != null
                      ? (widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsNeutral900
                          : FlutterFlowTheme.of(context).tsNeutral200)
                      : (widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsNeutral900
                          : FlutterFlowTheme.of(context).tsNeutral50));
                } else if (widget!.variant == Variant.primary) {
                  return FlutterFlowTheme.of(context).tsNeutral50;
                } else if (widget!.variant == Variant.dark) {
                  return FlutterFlowTheme.of(context).tsNeutral900;
                } else if (widget!.variant == Variant.neutral) {
                  return FlutterFlowTheme.of(context).tsNeutral0;
                } else {
                  return Color(0x00000000);
                }
              }(),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widget!.unselectable
              ? () {
                  if (widget!.styleOnSelected) {
                    return (_model.listSelected != null
                        ? FlutterFlowTheme.of(context).tsPrimaryDefault
                        : (widget!.variant == Variant.dark
                            ? FlutterFlowTheme.of(context).tsNeutral800
                            : FlutterFlowTheme.of(context).tsNeutral300));
                  } else if (widget!.hasError) {
                    return FlutterFlowTheme.of(context).tsDanger400;
                  } else if (widget!.noBorder) {
                    return Color(0x00000000);
                  } else if (widget!.variant == Variant.dark) {
                    return FlutterFlowTheme.of(context).tsNeutral800;
                  } else if (widget!.variant == Variant.neutral) {
                    return FlutterFlowTheme.of(context).tsNeutral300;
                  } else {
                    return FlutterFlowTheme.of(context).tsNeutral300;
                  }
                }()
              : () {
                  if (widget!.styleOnSelected) {
                    return (_model.listSelected != null
                        ? FlutterFlowTheme.of(context).tsPrimaryDefault
                        : (widget!.variant == Variant.dark
                            ? FlutterFlowTheme.of(context).tsNeutral800
                            : FlutterFlowTheme.of(context).tsNeutral300));
                  } else if (widget!.hasError) {
                    return FlutterFlowTheme.of(context).tsDanger400;
                  } else if (widget!.noBorder) {
                    return Color(0x00000000);
                  } else if (widget!.variant == Variant.dark) {
                    return FlutterFlowTheme.of(context).tsNeutral800;
                  } else if (widget!.variant == Variant.neutral) {
                    return FlutterFlowTheme.of(context).tsNeutral300;
                  } else {
                    return FlutterFlowTheme.of(context).tsNeutral300;
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
                if (_model.listSelected != null) {
                  return Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
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
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                      child: widget!.selectedIcon != null
                                          ? widget!.selectedIcon!
                                          : widget!.icon!,
                                    ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          valueOrDefault<double>(
                                            (widget!.icon != null) ||
                                                    (widget!.selectedIcon !=
                                                        null)
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
                                                _model.listSelected != null
                                                    ? functions
                                                        .getDataFromField(
                                                            _model
                                                                .listSelected!,
                                                            widget!.fieldName)
                                                    : widget!.label,
                                                '-',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .tsFontMediumSm
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontMediumSm
                                                              .fontStyle,
                                                    ),
                                                    color: widget!.variant ==
                                                            Variant.dark
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsPrimaryDefault
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontMediumSm
                                                            .fontStyle,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'w6hln533' /*   */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .tsFontMediumSm
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontMediumSm
                                                              .fontStyle,
                                                    ),
                                                    color: widget!.variant ==
                                                            Variant.dark
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsPrimaryDefault
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontMediumSm
                                                            .fontStyle,
                                                  ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tsNeutral800,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
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
                            _model.listSelected = null;
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
                      if (!widget!.unselectable) {
                        await _model.updateComponent(context);
                        safeSetState(() {});
                        await widget.executeAction?.call(
                          _model.listSelected,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Row(
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
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    widget!.icon != null ? 0.0 : 16.0,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget!.label,
                                        'SingleSelect',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .tsFontMediumSm
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontMediumSm
                                                      .fontStyle,
                                            ),
                                            color: widget!.unselectable
                                                ? () {
                                                    if (widget!.variant ==
                                                        Variant.dark) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .tsNeutral0;
                                                    } else if (widget!
                                                            .variant ==
                                                        Variant.neutral) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .tsNeutral700;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .tsNeutral800;
                                                    }
                                                  }()
                                                : (widget!.variant ==
                                                        Variant.dark
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral0
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral800),
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
                                      color: widget!.unselectable
                                          ? () {
                                              if (widget!.variant ==
                                                  Variant.dark) {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsNeutral0;
                                              } else if (widget!.variant ==
                                                  Variant.neutral) {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsNeutral700;
                                              } else {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .tsNeutral800;
                                              }
                                            }()
                                          : (widget!.variant == Variant.dark
                                              ? FlutterFlowTheme.of(context)
                                                  .tsNeutral0
                                              : FlutterFlowTheme.of(context)
                                                  .tsNeutral800),
                                      size: 16.0,
                                    ),
                                  ),
                                ],
                              ),
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
