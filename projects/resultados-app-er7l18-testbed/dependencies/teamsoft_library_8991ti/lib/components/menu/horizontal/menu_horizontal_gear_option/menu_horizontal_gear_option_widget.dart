import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizontal_gear_option_model.dart';
export 'menu_horizontal_gear_option_model.dart';

class MenuHorizontalGearOptionWidget extends StatefulWidget {
  const MenuHorizontalGearOptionWidget({
    super.key,
    required this.gearOption,
  });

  final List<dynamic>? gearOption;

  @override
  State<MenuHorizontalGearOptionWidget> createState() =>
      _MenuHorizontalGearOptionWidgetState();
}

class _MenuHorizontalGearOptionWidgetState
    extends State<MenuHorizontalGearOptionWidget> {
  late MenuHorizontalGearOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontalGearOptionModel());

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
          child: Builder(
            builder: (context) {
              final dynamicList = widget!.gearOption!.toList();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(dynamicList.length, (dynamicListIndex) {
                  final dynamicListItem = dynamicList[dynamicListIndex];
                  return Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          getJsonField(
                            dynamicListItem,
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
                                color:
                                    FlutterFlowTheme.of(context).tsTextDefault,
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
        ),
      ),
    );
  }
}
