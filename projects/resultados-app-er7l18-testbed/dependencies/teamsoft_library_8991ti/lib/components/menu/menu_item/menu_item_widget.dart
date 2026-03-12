import '/backend/schema/enums/enums.dart';
import '/components/menu/modal_collapsed_menu_option/modal_collapsed_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_item_model.dart';
export 'menu_item_model.dart';

class MenuItemWidget extends StatefulWidget {
  const MenuItemWidget({
    super.key,
    required this.menuData,
    required this.config,
    this.variant,
    bool? collapsed,
    required this.currentRouteMenuItem,
  }) : this.collapsed = collapsed ?? false;

  final dynamic menuData;
  final dynamic config;
  final Variant? variant;
  final bool collapsed;
  final String? currentRouteMenuItem;

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  late MenuItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuItemModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: true)
          ..addListener(() => safeSetState(() {}));
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false)
          ..addListener(() => safeSetState(() {}));
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

    return Builder(
      builder: (context) {
        if (getJsonField(
              widget!.menuData,
              r'''$.children[0]''',
            ) ==
            null) {
          return MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer ?? MouseCursor.defer,
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await actions.customNavigation(
                  context,
                  getJsonField(
                    widget!.menuData,
                    r'''$.page''',
                  ).toString(),
                  widget!.menuData,
                );
              },
              child: Container(
                height: 36.0,
                decoration: BoxDecoration(
                  color: () {
                    if ((widget!.currentRouteMenuItem ==
                            getJsonField(
                              widget!.menuData,
                              r'''$.page''',
                            ).toString()) &&
                        (widget!.variant == Variant.primary)) {
                      return FlutterFlowTheme.of(context).tsPrimary50;
                    } else if ((widget!.currentRouteMenuItem ==
                            getJsonField(
                              widget!.menuData,
                              r'''$.page''',
                            ).toString()) &&
                        (widget!.variant == Variant.dark)) {
                      return FlutterFlowTheme.of(context).tsNeutral850;
                    } else if (_model.mouseRegionHovered1!) {
                      return () {
                        if (widget!.variant == Variant.neutral) {
                          return FlutterFlowTheme.of(context).tsNeutral100;
                        } else if (widget!.variant == Variant.primary) {
                          return FlutterFlowTheme.of(context).tsPrimary100;
                        } else if (widget!.variant == Variant.dark) {
                          return FlutterFlowTheme.of(context).tsNeutral850;
                        } else {
                          return FlutterFlowTheme.of(context).tsNeutral100;
                        }
                      }();
                    } else {
                      return Color(0x00000000);
                    }
                  }(),
                  borderRadius: BorderRadius.circular(valueOrDefault<double>(
                    getJsonField(
                      widget!.config,
                      r'''$.radioContainer''',
                    ),
                    4.0,
                  )),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (getJsonField(
                            widget!.menuData,
                            r'''$.icon''',
                          ) !=
                          null)
                        Container(
                          width: 16.0,
                          height: 16.0,
                          child: custom_widgets.CustomIcon(
                            width: 16.0,
                            height: 16.0,
                            iconName: getJsonField(
                              widget!.menuData,
                              r'''$.icon''',
                            ).toString(),
                            color: () {
                              if ((widget!.currentRouteMenuItem ==
                                      getJsonField(
                                        widget!.menuData,
                                        r'''$.page''',
                                      ).toString()) &&
                                  (widget!.variant == Variant.primary)) {
                                return FlutterFlowTheme.of(context)
                                    .tsPrimary600;
                              } else if ((widget!.currentRouteMenuItem ==
                                      getJsonField(
                                        widget!.menuData,
                                        r'''$.page''',
                                      ).toString()) &&
                                  (widget!.variant == Variant.dark)) {
                                return FlutterFlowTheme.of(context)
                                    .tsPrimary300;
                              } else if (widget!.variant == Variant.neutral) {
                                return FlutterFlowTheme.of(context)
                                    .tsNeutral1000;
                              } else if (widget!.variant == Variant.dark) {
                                return FlutterFlowTheme.of(context).tsNeutral0;
                              } else {
                                return FlutterFlowTheme.of(context)
                                    .tsNeutral1000;
                              }
                            }(),
                          ),
                        ),
                      if (!widget!.collapsed)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              getJsonField(
                                widget!.menuData,
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
                                    color: () {
                                      if ((widget!.currentRouteMenuItem ==
                                              getJsonField(
                                                widget!.menuData,
                                                r'''$.page''',
                                              ).toString()) &&
                                          (widget!.variant ==
                                              Variant.primary)) {
                                        return FlutterFlowTheme.of(context)
                                            .tsPrimary600;
                                      } else if ((widget!
                                                  .currentRouteMenuItem ==
                                              getJsonField(
                                                widget!.menuData,
                                                r'''$.page''',
                                              ).toString()) &&
                                          (widget!.variant == Variant.dark)) {
                                        return FlutterFlowTheme.of(context)
                                            .tsPrimary300;
                                      } else if (widget!.variant ==
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
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            onEnter: ((event) async {
              safeSetState(() => _model.mouseRegionHovered1 = true);
            }),
            onExit: ((event) async {
              safeSetState(() => _model.mouseRegionHovered1 = false);
            }),
          );
        } else {
          return Builder(
            builder: (context) {
              if (!FFAppState().menuCollpased) {
                return Builder(
                  builder: (context) {
                    if (functions.currentPageExistsInMenu(
                        getJsonField(
                          widget!.menuData,
                          r'''$.children''',
                          true,
                        )!,
                        widget!.currentRouteMenuItem!)) {
                      return Container(
                        width: double.infinity,
                        color: Color(0x00000000),
                        child: ExpandableNotifier(
                          controller: _model.expandableExpandableController1,
                          child: ExpandablePanel(
                            header: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (getJsonField(
                                        widget!.menuData,
                                        r'''$.icon''',
                                      ) !=
                                      null)
                                    Container(
                                      width: 16.0,
                                      height: 16.0,
                                      child: custom_widgets.CustomIcon(
                                        width: 16.0,
                                        height: 16.0,
                                        iconName: getJsonField(
                                          widget!.menuData,
                                          r'''$.icon''',
                                        ).toString(),
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
                                      ),
                                    ),
                                  if (!FFAppState().menuCollpased)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            widget!.menuData,
                                            r'''$.title''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .tsFontNormalSm
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if (widget!.variant ==
                                                      Variant.neutral) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral1000;
                                                  } else if (widget!.variant ==
                                                      Variant.dark) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral0;
                                                  } else {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral1000;
                                                  }
                                                }(),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final submenu = getJsonField(
                                    widget!.menuData,
                                    r'''$.children''',
                                  ).toList();

                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(submenu.length,
                                          (submenuIndex) {
                                        final submenuItem =
                                            submenu[submenuIndex];
                                        return wrapWithModel(
                                          model:
                                              _model.menuItemModels1.getModel(
                                            submenuIndex.toString(),
                                            submenuIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          updateOnChange: true,
                                          child: MenuItemWidget(
                                            key: Key(
                                              'Keyds4_${submenuIndex.toString()}',
                                            ),
                                            menuData: submenuItem,
                                            config: widget!.config!,
                                            variant: widget!.variant,
                                            collapsed: false,
                                            currentRouteMenuItem:
                                                widget!.currentRouteMenuItem!,
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                            theme: ExpandableThemeData(
                              tapHeaderToExpand: true,
                              tapBodyToExpand: false,
                              tapBodyToCollapse: false,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              hasIcon: true,
                              expandIcon: FFIcons.kcaretDown,
                              collapseIcon: FFIcons.kcaretUp,
                              iconColor: () {
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
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        color: Color(0x00000000),
                        child: ExpandableNotifier(
                          controller: _model.expandableExpandableController2,
                          child: ExpandablePanel(
                            header: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (getJsonField(
                                        widget!.menuData,
                                        r'''$.icon''',
                                      ) !=
                                      null)
                                    Container(
                                      width: 16.0,
                                      height: 16.0,
                                      child: custom_widgets.CustomIcon(
                                        width: 16.0,
                                        height: 16.0,
                                        iconName: getJsonField(
                                          widget!.menuData,
                                          r'''$.icon''',
                                        ).toString(),
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
                                      ),
                                    ),
                                  if (!FFAppState().menuCollpased)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        getJsonField(
                                          widget!.menuData,
                                          r'''$.title''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                              color: () {
                                                if (widget!.variant ==
                                                    Variant.neutral) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral1000;
                                                } else if (widget!.variant ==
                                                    Variant.dark) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral0;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral1000;
                                                }
                                              }(),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final submenu = getJsonField(
                                    widget!.menuData,
                                    r'''$.children''',
                                  ).toList();

                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(submenu.length,
                                          (submenuIndex) {
                                        final submenuItem =
                                            submenu[submenuIndex];
                                        return wrapWithModel(
                                          model:
                                              _model.menuItemModels2.getModel(
                                            submenuIndex.toString(),
                                            submenuIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          updateOnChange: true,
                                          child: MenuItemWidget(
                                            key: Key(
                                              'Keyemy_${submenuIndex.toString()}',
                                            ),
                                            menuData: submenuItem,
                                            config: widget!.config!,
                                            variant: widget!.variant,
                                            collapsed: false,
                                            currentRouteMenuItem:
                                                widget!.currentRouteMenuItem!,
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                            theme: ExpandableThemeData(
                              tapHeaderToExpand: true,
                              tapBodyToExpand: false,
                              tapBodyToCollapse: false,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              hasIcon: true,
                              expandIcon: FFIcons.kcaretDown,
                              collapseIcon: FFIcons.kcaretUp,
                              iconColor: () {
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
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              } else {
                return MouseRegion(
                  opaque: false,
                  cursor: MouseCursor.defer ?? MouseCursor.defer,
                  child: Builder(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showAlignedDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          isGlobal: false,
                          avoidOverflow: false,
                          targetAnchor: AlignmentDirectional(1.0, 0.0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(-1.0, 0.0)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                width: 208.0,
                                child: ModalCollapsedMenuOptionWidget(
                                  variant: widget!.variant!,
                                  options: widget!.menuData!,
                                  config: widget!.config!,
                                  currentRouteMenuOption:
                                      widget!.currentRouteMenuItem!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: () {
                            if (functions.currentPageExistsInMenu(
                                    getJsonField(
                                      widget!.menuData,
                                      r'''$.children''',
                                      true,
                                    )!,
                                    widget!.currentRouteMenuItem!) &&
                                (widget!.variant == Variant.primary)) {
                              return FlutterFlowTheme.of(context).tsPrimary50;
                            } else if (functions.currentPageExistsInMenu(
                                    getJsonField(
                                      widget!.menuData,
                                      r'''$.children''',
                                      true,
                                    )!,
                                    widget!.currentRouteMenuItem!) &&
                                (widget!.variant == Variant.dark)) {
                              return FlutterFlowTheme.of(context).tsNeutral850;
                            } else if (_model.mouseRegionHovered1!) {
                              return () {
                                if (widget!.variant == Variant.neutral) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral100;
                                } else if (widget!.variant == Variant.primary) {
                                  return FlutterFlowTheme.of(context)
                                      .tsPrimary100;
                                } else if (widget!.variant == Variant.dark) {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral850;
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .tsNeutral100;
                                }
                              }();
                            } else {
                              return Color(0x00000000);
                            }
                          }(),
                          borderRadius:
                              BorderRadius.circular(valueOrDefault<double>(
                            getJsonField(
                              widget!.config,
                              r'''$.radioContainer''',
                            ),
                            4.0,
                          )),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (getJsonField(
                                    widget!.menuData,
                                    r'''$.icon''',
                                  ) !=
                                  null)
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  child: custom_widgets.CustomIcon(
                                    width: 16.0,
                                    height: 16.0,
                                    iconName: getJsonField(
                                      widget!.menuData,
                                      r'''$.icon''',
                                    ).toString(),
                                    color: () {
                                      if (functions.currentPageExistsInMenu(
                                              getJsonField(
                                                widget!.menuData,
                                                r'''$.children''',
                                                true,
                                              )!,
                                              widget!.currentRouteMenuItem!) &&
                                          (widget!.variant ==
                                              Variant.primary)) {
                                        return FlutterFlowTheme.of(context)
                                            .tsPrimary600;
                                      } else if (functions
                                              .currentPageExistsInMenu(
                                                  getJsonField(
                                                    widget!.menuData,
                                                    r'''$.children''',
                                                    true,
                                                  )!,
                                                  widget!
                                                      .currentRouteMenuItem!) &&
                                          (widget!.variant == Variant.dark)) {
                                        return FlutterFlowTheme.of(context)
                                            .tsPrimary300;
                                      } else if (widget!.variant ==
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
                                  ),
                                ),
                              if (!FFAppState().menuCollpased)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    getJsonField(
                                      widget!.menuData,
                                      r'''$.title''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .tsFontNormalSm
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .tsFontNormalSm
                                                    .fontStyle,
                                          ),
                                          color: () {
                                            if (functions
                                                    .currentPageExistsInMenu(
                                                        getJsonField(
                                                          widget!.menuData,
                                                          r'''$.children''',
                                                          true,
                                                        )!,
                                                        widget!
                                                            .currentRouteMenuItem!) &&
                                                (widget!.variant ==
                                                    Variant.primary)) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsPrimary600;
                                            } else if (functions
                                                    .currentPageExistsInMenu(
                                                        getJsonField(
                                                          widget!.menuData,
                                                          r'''$.children''',
                                                          true,
                                                        )!,
                                                        widget!
                                                            .currentRouteMenuItem!) &&
                                                (widget!.variant ==
                                                    Variant.dark)) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsPrimary300;
                                            } else if (widget!.variant ==
                                                Variant.neutral) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsNeutral1000;
                                            } else if (widget!.variant ==
                                                Variant.dark) {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsNeutral0;
                                            } else {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .tsNeutral1000;
                                            }
                                          }(),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onEnter: ((event) async {
                    safeSetState(() => _model.mouseRegionHovered2 = true);
                  }),
                  onExit: ((event) async {
                    safeSetState(() => _model.mouseRegionHovered2 = false);
                  }),
                );
              }
            },
          );
        }
      },
    );
  }
}
