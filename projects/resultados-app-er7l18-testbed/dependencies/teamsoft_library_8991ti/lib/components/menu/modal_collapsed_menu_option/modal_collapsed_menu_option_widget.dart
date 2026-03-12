import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'modal_collapsed_menu_option_model.dart';
export 'modal_collapsed_menu_option_model.dart';

class ModalCollapsedMenuOptionWidget extends StatefulWidget {
  const ModalCollapsedMenuOptionWidget({
    super.key,
    required this.variant,
    required this.options,
    required this.config,
    required this.currentRouteMenuOption,
  });

  final Variant? variant;
  final dynamic options;
  final dynamic config;
  final String? currentRouteMenuOption;

  @override
  State<ModalCollapsedMenuOptionWidget> createState() =>
      _ModalCollapsedMenuOptionWidgetState();
}

class _ModalCollapsedMenuOptionWidgetState
    extends State<ModalCollapsedMenuOptionWidget> {
  late ModalCollapsedMenuOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModalCollapsedMenuOptionModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
      child: Container(
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
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral300;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral300;
              }
            }(),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 16.0,
                      height: 16.0,
                      child: custom_widgets.CustomIcon(
                        width: 16.0,
                        height: 16.0,
                        iconName: getJsonField(
                          widget!.options,
                          r'''$.icon''',
                        ).toString(),
                        color: () {
                          if (widget!.variant == Variant.neutral) {
                            return FlutterFlowTheme.of(context).tsNeutral1000;
                          } else if (widget!.variant == Variant.dark) {
                            return FlutterFlowTheme.of(context).tsNeutral0;
                          } else {
                            return FlutterFlowTheme.of(context).tsNeutral1000;
                          }
                        }(),
                      ),
                    ),
                    Text(
                      getJsonField(
                        widget!.options,
                        r'''$.title''',
                      ).toString(),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context)
                          .tsFontSemiboldSm
                          .override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldSm
                                  .fontStyle,
                            ),
                            color: () {
                              if (widget!.variant == Variant.neutral) {
                                return FlutterFlowTheme.of(context)
                                    .tsNeutral1000;
                              } else if (widget!.variant == Variant.dark) {
                                return FlutterFlowTheme.of(context).tsNeutral0;
                              } else {
                                return FlutterFlowTheme.of(context)
                                    .tsNeutral1000;
                              }
                            }(),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldSm
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: () {
                if (widget!.variant == Variant.neutral) {
                  return FlutterFlowTheme.of(context).tsNeutral300;
                } else if (widget!.variant == Variant.dark) {
                  return FlutterFlowTheme.of(context).tsNeutral850;
                } else {
                  return FlutterFlowTheme.of(context).tsNeutral300;
                }
              }(),
            ),
            Builder(
              builder: (context) {
                final dynamiclistMenuOptionsCollapsed = getJsonField(
                  widget!.options,
                  r'''$.children''',
                ).toList();

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children:
                      List.generate(dynamiclistMenuOptionsCollapsed.length,
                          (dynamiclistMenuOptionsCollapsedIndex) {
                    final dynamiclistMenuOptionsCollapsedItem =
                        dynamiclistMenuOptionsCollapsed[
                            dynamiclistMenuOptionsCollapsedIndex];
                    return wrapWithModel(
                      model: _model.menuItemModels.getModel(
                        dynamiclistMenuOptionsCollapsedIndex.toString(),
                        dynamiclistMenuOptionsCollapsedIndex,
                      ),
                      updateCallback: () => safeSetState(() {}),
                      child: MenuItemWidget(
                        key: Key(
                          'Keydt4_${dynamiclistMenuOptionsCollapsedIndex.toString()}',
                        ),
                        menuData: dynamiclistMenuOptionsCollapsedItem,
                        variant: widget!.variant,
                        config: widget!.config!,
                        collapsed: false,
                        currentRouteMenuItem: widget!.currentRouteMenuOption!,
                      ),
                    );
                  }).divide(SizedBox(height: 4.0)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
