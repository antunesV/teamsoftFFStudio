import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_action_footer_model.dart';
export 'menu_action_footer_model.dart';

class MenuActionFooterWidget extends StatefulWidget {
  const MenuActionFooterWidget({
    super.key,
    required this.userData,
    required this.menuOptions,
    this.variant,
  });

  final dynamic userData;
  final List<dynamic>? menuOptions;
  final Variant? variant;

  @override
  State<MenuActionFooterWidget> createState() => _MenuActionFooterWidgetState();
}

class _MenuActionFooterWidgetState extends State<MenuActionFooterWidget> {
  late MenuActionFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuActionFooterModel());

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
      width: 212.0,
      decoration: BoxDecoration(
        color: () {
          if (widget!.variant == Variant.neutral) {
            return FlutterFlowTheme.of(context).tsNeutral0;
          } else if (widget!.variant == Variant.dark) {
            return FlutterFlowTheme.of(context).tsNeutral950;
          } else {
            return FlutterFlowTheme.of(context).tsNeutral0;
          }
        }(),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: () {
            if (widget!.variant == Variant.neutral) {
              return FlutterFlowTheme.of(context).tsNeutral0;
            } else if (widget!.variant == Variant.dark) {
              return FlutterFlowTheme.of(context).tsNeutral850;
            } else {
              return FlutterFlowTheme.of(context).tsNeutral0;
            }
          }(),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
            builder: (context) {
              final dynamicListOptions = (widget!.menuOptions!.length > 0
                          ? widget!.menuOptions
                          : FFAppState().menuOptions)
                      ?.toList() ??
                  [];

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(dynamicListOptions.length,
                    (dynamicListOptionsIndex) {
                  final dynamicListOptionsItem =
                      dynamicListOptions[dynamicListOptionsIndex];
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.pop(
                                    context,
                                    getJsonField(
                                      dynamicListOptionsItem,
                                      r'''$.key''',
                                    ).toString());
                              },
                              child: Text(
                                getJsonField(
                                  dynamicListOptionsItem,
                                  r'''$.name''',
                                ).toString(),
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
                                      color: () {
                                        if (widget!.variant ==
                                            Variant.neutral) {
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
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
        ]
            .divide(SizedBox(height: 16.0))
            .addToStart(SizedBox(height: 8.0))
            .addToEnd(SizedBox(height: 8.0)),
      ),
    );
  }
}
