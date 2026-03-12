import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_header_model.dart';
export 'menu_header_model.dart';

class MenuHeaderWidget extends StatefulWidget {
  const MenuHeaderWidget({
    super.key,
    String? imagem,
    this.imageHeight,
    int? imageWidth,
    bool? isMobile,
    required this.variant,
  })  : this.imagem = imagem ??
            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/teamsoft-library-8991ti/assets/jc1oe59h9a0y/teamsoft.jpg',
        this.imageWidth = imageWidth ?? 160,
        this.isMobile = isMobile ?? false;

  final String imagem;
  final int? imageHeight;
  final int imageWidth;
  final bool isMobile;
  final Variant? variant;

  @override
  State<MenuHeaderWidget> createState() => _MenuHeaderWidgetState();
}

class _MenuHeaderWidgetState extends State<MenuHeaderWidget> {
  late MenuHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHeaderModel());

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
      height: 80.0,
      decoration: BoxDecoration(),
      child: Builder(
        builder: (context) {
          if (FFAppState().menuCollpased) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().menuCollpased =
                        !(FFAppState().menuCollpased ?? true);
                    safeSetState(() {});
                  },
                  child: Icon(
                    FFIcons.kcaretCircleRightFill,
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                    size: 24.0,
                  ),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                  child: Image.network(
                    widget!.imagem,
                    width: widget!.imageWidth.toDouble(),
                    height: widget!.imageHeight?.toDouble(),
                    fit: BoxFit.contain,
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (widget!.isMobile) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FFIcons.kx,
                          color: () {
                            if (widget!.variant == Variant.dark) {
                              return FlutterFlowTheme.of(context)
                                  .tsTextInverter;
                            } else if (widget!.variant == Variant.primary) {
                              return FlutterFlowTheme.of(context)
                                  .tsPrimaryDefault;
                            } else {
                              return FlutterFlowTheme.of(context)
                                  .tsPrimaryDefault;
                            }
                          }(),
                          size: 24.0,
                        ),
                      );
                    } else {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().menuCollpased =
                              !(FFAppState().menuCollpased ?? true);
                          safeSetState(() {});
                        },
                        child: Icon(
                          FFIcons.kcaretCircleLeftFill,
                          color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                          size: 24.0,
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
