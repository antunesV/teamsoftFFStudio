import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizontal_tooltip_model.dart';
export 'menu_horizontal_tooltip_model.dart';

class MenuHorizontalTooltipWidget extends StatefulWidget {
  const MenuHorizontalTooltipWidget({
    super.key,
    this.items,
  });

  final List<dynamic>? items;

  @override
  State<MenuHorizontalTooltipWidget> createState() =>
      _MenuHorizontalTooltipWidgetState();
}

class _MenuHorizontalTooltipWidgetState
    extends State<MenuHorizontalTooltipWidget> {
  late MenuHorizontalTooltipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontalTooltipModel());

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
          constraints: BoxConstraints(
            maxWidth: 360.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tsNeutral0,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Builder(
            builder: (context) {
              final dynamicItems = widget!.items?.toList() ?? [];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    List.generate(dynamicItems.length, (dynamicItemsIndex) {
                  final dynamicItemsItem = dynamicItems[dynamicItemsIndex];
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await actions.customNavigation(
                              context,
                              getJsonField(
                                dynamicItemsItem,
                                r'''$.page''',
                              ).toString(),
                              dynamicItemsItem,
                            );
                          },
                          child: Container(
                            height: 36.0,
                            decoration: BoxDecoration(),
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                getJsonField(
                                  dynamicItemsItem,
                                  r'''$.title''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldSm
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontSemiboldSm
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
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
                          ),
                        ),
                      ),
                    ],
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
