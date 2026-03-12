import '/components/menu/horizontal/menu_horizonta_option_user/menu_horizonta_option_user_widget.dart';
import '/components/menu/horizontal/menu_horizontal_gear_option/menu_horizontal_gear_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizontal_user_model.dart';
export 'menu_horizontal_user_model.dart';

class MenuHorizontalUserWidget extends StatefulWidget {
  const MenuHorizontalUserWidget({
    super.key,
    required this.userData,
    required this.userOption,
    required this.gearOptions,
  });

  final dynamic userData;
  final List<dynamic>? userOption;
  final List<dynamic>? gearOptions;

  @override
  State<MenuHorizontalUserWidget> createState() =>
      _MenuHorizontalUserWidgetState();
}

class _MenuHorizontalUserWidgetState extends State<MenuHorizontalUserWidget> {
  late MenuHorizontalUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontalUserModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
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
                  avoidOverflow: true,
                  targetAnchor: AlignmentDirectional(0.0, 1.0)
                      .resolve(Directionality.of(context)),
                  followerAnchor: AlignmentDirectional(0.0, -1.0)
                      .resolve(Directionality.of(context)),
                  builder: (dialogContext) {
                    return Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 128.0,
                        child: MenuHorizontalGearOptionWidget(
                          gearOption: widget!.gearOptions!,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _model.mouseRegionOptionsHovered!
                      ? Color(0x27FFFFFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FFIcons.kgearFill,
                    color: FlutterFlowTheme.of(context).tsNeutral0,
                    size: 24.0,
                  ),
                ),
              ),
            ),
          ),
          onEnter: ((event) async {
            safeSetState(() => _model.mouseRegionOptionsHovered = true);
          }),
          onExit: ((event) async {
            safeSetState(() => _model.mouseRegionOptionsHovered = false);
          }),
        ),
        MouseRegion(
          opaque: true,
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
                  avoidOverflow: true,
                  targetAnchor: AlignmentDirectional(0.0, 1.0)
                      .resolve(Directionality.of(context)),
                  followerAnchor: AlignmentDirectional(0.0, -1.0)
                      .resolve(Directionality.of(context)),
                  builder: (dialogContext) {
                    return Material(
                      color: Colors.transparent,
                      child: MenuHorizontaOptionUserWidget(
                        userData: widget!.userData!,
                        userOptions: widget!.userOption!,
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _model.mouseRegionUserHovered!
                      ? Color(0x27FFFFFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 28.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                          borderRadius: BorderRadius.circular(80.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).tsNeutral0,
                          ),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          (String var1) {
                            return var1
                                .split(' ')
                                .take(2)
                                .map((p) => p[0].toUpperCase())
                                .join();
                          }(getJsonField(
                            widget!.userData,
                            r'''$.name''',
                          ).toString()),
                          style: FlutterFlowTheme.of(context)
                              .tsFontSemiboldXs
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldXs
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).tsNeutral0,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldXs
                                    .fontStyle,
                              ),
                        ),
                      ),
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
            safeSetState(() => _model.mouseRegionUserHovered = true);
          }),
          onExit: ((event) async {
            safeSetState(() => _model.mouseRegionUserHovered = false);
          }),
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
