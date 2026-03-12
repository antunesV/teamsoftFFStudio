import '/components/menu/horizontal/menu_horizontal_tooltip/menu_horizontal_tooltip_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizonta_items_model.dart';
export 'menu_horizonta_items_model.dart';

class MenuHorizontaItemsWidget extends StatefulWidget {
  const MenuHorizontaItemsWidget({
    super.key,
    required this.info,
  });

  final dynamic info;

  @override
  State<MenuHorizontaItemsWidget> createState() =>
      _MenuHorizontaItemsWidgetState();
}

class _MenuHorizontaItemsWidgetState extends State<MenuHorizontaItemsWidget> {
  late MenuHorizontaItemsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontaItemsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      child: Builder(
        builder: (context) => InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getJsonField(
                  widget!.info,
                  r'''$.children[0]''',
                ) !=
                null) {
              await showAlignedDialog(
                barrierColor: Colors.transparent,
                context: context,
                isGlobal: false,
                avoidOverflow: false,
                targetAnchor: AlignmentDirectional(0.0, 1.0)
                    .resolve(Directionality.of(context)),
                followerAnchor: AlignmentDirectional(0.0, -1.0)
                    .resolve(Directionality.of(context)),
                builder: (dialogContext) {
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 168.0,
                      child: MenuHorizontalTooltipWidget(
                        items: getJsonField(
                          widget!.info,
                          r'''$.children''',
                          true,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              await actions.customNavigation(
                context,
                getJsonField(
                  widget!.info,
                  r'''$.page''',
                ).toString(),
                widget!.info,
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: _model.mouseRegionHovered!
                  ? Color(0x27FFFFFF)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16.0,
                    height: 16.0,
                    child: custom_widgets.CustomIcon(
                      width: 16.0,
                      height: 16.0,
                      iconName: getJsonField(
                        widget!.info,
                        r'''$.icon''',
                      ).toString(),
                      color: FlutterFlowTheme.of(context).tsNeutral0,
                    ),
                  ),
                  Text(
                    getJsonField(
                      widget!.info,
                      r'''$.title''',
                    ).toString(),
                    style:
                        FlutterFlowTheme.of(context).tsFontSemiboldSm.override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldSm
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).tsNeutral0,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                  ),
                  if (getJsonField(
                        widget!.info,
                        r'''$.children[0]''',
                      ) !=
                      null)
                    Icon(
                      FFIcons.kcaretDown,
                      color: FlutterFlowTheme.of(context).tsNeutral0,
                      size: 16.0,
                    ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ),
        ),
      ),
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
      }),
    );
  }
}
