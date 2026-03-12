import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_action_footer/menu_action_footer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_footer_model.dart';
export 'menu_footer_model.dart';

class MenuFooterWidget extends StatefulWidget {
  const MenuFooterWidget({
    super.key,
    required this.userData,
    required this.callback,
    required this.menuOptions,
    bool? isSponsor,
    this.variant,
  }) : this.isSponsor = isSponsor ?? false;

  final dynamic userData;
  final Future Function(String info)? callback;
  final List<dynamic>? menuOptions;
  final bool isSponsor;
  final Variant? variant;

  @override
  State<MenuFooterWidget> createState() => _MenuFooterWidgetState();
}

class _MenuFooterWidgetState extends State<MenuFooterWidget> {
  late MenuFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuFooterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      height: 40.0,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            FFIcons.kuserCircle,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral1000;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral1000;
              }
            }(),
            size: 32.0,
          ),
          if (!FFAppState().menuCollpased)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget!.isSponsor
                            ? getJsonField(
                                widget!.userData,
                                r'''$.sponsor_name''',
                              ).toString()
                            : getJsonField(
                                widget!.userData,
                                r'''$.name''',
                              ).toString(),
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                              color: () {
                                if (widget!.variant == Variant.neutral) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral1000;
                                } else if (widget!.variant == Variant.dark) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral0;
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral1000;
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                              lineHeight: 1.35,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget!.menuOptions != null &&
                        (widget!.menuOptions)!.isNotEmpty)
                      Builder(
                        builder: (context) {
                          if (widget!.menuOptions?.length == 1) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await widget.callback?.call(
                                  getJsonField(
                                    widget!.menuOptions!.firstOrNull,
                                    r'''$.key''',
                                  ).toString(),
                                );
                              },
                              child: Container(
                                width: 16.0,
                                height: 16.0,
                                child: custom_widgets.CustomIcon(
                                  width: 16.0,
                                  height: 16.0,
                                  iconName: getJsonField(
                                    widget!.menuOptions!.firstOrNull,
                                    r'''$.icon''',
                                  ).toString(),
                                  color: colorFromCssString(
                                    getJsonField(
                                      widget!.menuOptions!.firstOrNull,
                                      r'''$.color''',
                                    ).toString(),
                                    defaultColor: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showAlignedDialog(
                                      barrierColor: Colors.transparent,
                                      context: context,
                                      isGlobal: false,
                                      avoidOverflow: true,
                                      targetAnchor: AlignmentDirectional(
                                              0.0, 1.0)
                                          .resolve(Directionality.of(context)),
                                      followerAnchor: AlignmentDirectional(
                                              -0.8, 1.7)
                                          .resolve(Directionality.of(context)),
                                      builder: (dialogContext) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: MenuActionFooterWidget(
                                            userData: widget!.userData!,
                                            menuOptions: widget!.menuOptions!,
                                            variant: widget!.variant,
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.outputMenu = value));

                                    await widget.callback?.call(
                                      _model.outputMenu!,
                                    );

                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    FFIcons.kdotsThreeVertical,
                                    color: () {
                                      if (widget!.variant == Variant.neutral) {
                                        return FlutterFlowTheme.of(context)
                                            .tsNeutral1000;
                                      } else if (widget!.variant ==
                                          Variant.dark) {
                                        return FlutterFlowTheme.of(context)
                                            .tsNeutral0;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .tsNeutral1000;
                                      }
                                    }(),
                                    size: 24.0,
                                  ),
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
        ],
      ),
    );
  }
}
