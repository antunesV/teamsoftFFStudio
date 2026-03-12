import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lazy_loading_table_model.dart';
export 'lazy_loading_table_model.dart';

class LazyLoadingTableWidget extends StatefulWidget {
  const LazyLoadingTableWidget({
    super.key,
    this.variant,
  });

  final Variant? variant;

  @override
  State<LazyLoadingTableWidget> createState() => _LazyLoadingTableWidgetState();
}

class _LazyLoadingTableWidgetState extends State<LazyLoadingTableWidget>
    with TickerProviderStateMixin {
  late LazyLoadingTableModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LazyLoadingTableModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
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
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral900;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral0;
              }
            }(),
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).tsNeutral0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          } else if (widget!.variant == Variant.dark) {
                            return Color(0xFF505050);
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation1']!),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral900;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral0;
              }
            }(),
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).tsNeutral0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          } else if (widget!.variant == Variant.dark) {
                            return Color(0xFF505050);
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation2']!),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral900;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral0;
              }
            }(),
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).tsNeutral0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          } else if (widget!.variant == Variant.dark) {
                            return Color(0xFF505050);
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation3']!),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral900;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral0;
              }
            }(),
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).tsNeutral0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          } else if (widget!.variant == Variant.dark) {
                            return Color(0xFF505050);
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation4']!),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral0;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral900;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral0;
              }
            }(),
            boxShadow: [
              BoxShadow(
                blurRadius: 0.0,
                color: FlutterFlowTheme.of(context).tsNeutral0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          } else if (widget!.variant == Variant.dark) {
                            return Color(0xFF505050);
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral50;
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation5']!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
