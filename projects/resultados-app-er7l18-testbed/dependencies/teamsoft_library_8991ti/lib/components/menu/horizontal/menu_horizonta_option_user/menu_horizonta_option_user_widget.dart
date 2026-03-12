import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizonta_option_user_model.dart';
export 'menu_horizonta_option_user_model.dart';

class MenuHorizontaOptionUserWidget extends StatefulWidget {
  const MenuHorizontaOptionUserWidget({
    super.key,
    required this.userData,
    required this.userOptions,
  });

  final dynamic userData;
  final List<dynamic>? userOptions;

  @override
  State<MenuHorizontaOptionUserWidget> createState() =>
      _MenuHorizontaOptionUserWidgetState();
}

class _MenuHorizontaOptionUserWidgetState
    extends State<MenuHorizontaOptionUserWidget> {
  late MenuHorizontaOptionUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontaOptionUserModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 208.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tsNeutral0,
            boxShadow: [
              BoxShadow(
                blurRadius: 8.0,
                color: Color(0x02000000),
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      getJsonField(
                        widget!.userData,
                        r'''$.name''',
                      ).toString(),
                      style: FlutterFlowTheme.of(context)
                          .tsFontSemiboldBase
                          .override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).tsTextDefault,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).tsNeutral100,
              ),
              Builder(
                builder: (context) {
                  final dynamicList = widget!.userOptions!.toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(dynamicList.length, (dynamicListIndex) {
                      final dynamicListItem = dynamicList[dynamicListIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 8.0, 12.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              getJsonField(
                                dynamicListItem,
                                r'''$.title''',
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
                                    color: FlutterFlowTheme.of(context)
                                        .tsTextDefault,
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
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'f31ze6uc' /* Sair */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).tsFontNormalSm.override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).tsDanger500,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
