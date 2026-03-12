import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_footer/menu_footer_widget.dart';
import '/components/menu/menu_header/menu_header_widget.dart';
import '/components/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_model.dart';
export 'menu_model.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.menus,
    required this.logoImage,
    required this.config,
    required this.userData,
    String? version,
    required this.callbackAction,
    this.menuOptions,
    bool? isSponsor,
    this.variant,
    this.imageHeight,
    int? imageWidth,
    int? menuWidthExpanded,
    int? meuWidthCollapsed,
    bool? isMobile,
    this.currentRouteMenu,
  })  : this.version = version ?? 'v0.0.1',
        this.isSponsor = isSponsor ?? false,
        this.imageWidth = imageWidth ?? 160,
        this.menuWidthExpanded = menuWidthExpanded ?? 208,
        this.meuWidthCollapsed = meuWidthCollapsed ?? 48,
        this.isMobile = isMobile ?? false;

  final List<dynamic>? menus;
  final String? logoImage;
  final dynamic config;
  final dynamic userData;
  final String version;
  final Future Function(String action)? callbackAction;
  final List<dynamic>? menuOptions;
  final bool isSponsor;
  final Variant? variant;
  final int? imageHeight;
  final int imageWidth;
  final int menuWidthExpanded;
  final int meuWidthCollapsed;
  final bool isMobile;
  final String? currentRouteMenu;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late MenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentPage = await actions.getCurrentPage(
        context,
      );
      if (widget!.isMobile) {
        FFAppState().menuCollpased = false;
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
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: FFAppState().menuCollpased
                ? widget!.meuWidthCollapsed.toDouble()
                : widget!.menuWidthExpanded.toDouble(),
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(16.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(16.0),
              ),
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        child: wrapWithModel(
                                          model: _model.menuHeaderModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          updateOnChange: true,
                                          child: MenuHeaderWidget(
                                            imagem: widget!.logoImage!,
                                            imageHeight: widget!.imageHeight,
                                            imageWidth: widget!.imageWidth,
                                            isMobile: widget!.isMobile,
                                            variant: widget!.variant!,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 16.0),
                                      child: Builder(
                                        builder: (context) {
                                          final menu = widget!.menus!.toList();

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  menu.length, (menuIndex) {
                                                final menuItem =
                                                    menu[menuIndex];
                                                return wrapWithModel(
                                                  model: _model.menuItemModels
                                                      .getModel(
                                                    menuIndex.toString(),
                                                    menuIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  updateOnChange: true,
                                                  child: MenuItemWidget(
                                                    key: Key(
                                                      'Keyv3j_${menuIndex.toString()}',
                                                    ),
                                                    menuData: menuItem,
                                                    config: widget!.config!,
                                                    variant: widget!.variant,
                                                    collapsed: FFAppState()
                                                        .menuCollpased,
                                                    currentRouteMenuItem:
                                                        widget!
                                                            .currentRouteMenu!,
                                                  ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (getJsonField(
                                            widget!.userData,
                                            r'''$.id''',
                                          ) !=
                                          null)
                                        Expanded(
                                          child: Container(
                                            child: wrapWithModel(
                                              model: _model.menuFooterModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: MenuFooterWidget(
                                                userData: widget!.userData!,
                                                menuOptions:
                                                    widget!.menuOptions!,
                                                isSponsor: widget!.isSponsor,
                                                variant: widget!.variant,
                                                callback: (info) async {
                                                  await widget.callbackAction
                                                      ?.call(
                                                    info,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget!.version,
                                        style: FlutterFlowTheme.of(context)
                                            .tsFontNormalXs
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalXs
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalXs
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsNeutral600,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalXs
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalXs
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
