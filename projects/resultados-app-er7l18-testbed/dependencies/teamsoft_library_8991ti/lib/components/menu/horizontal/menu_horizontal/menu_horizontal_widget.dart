import '/components/menu/horizontal/menu_horizonta_options_page/menu_horizonta_options_page_widget.dart';
import '/components/menu/horizontal/menu_horizontal_user/menu_horizontal_user_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizontal_model.dart';
export 'menu_horizontal_model.dart';

class MenuHorizontalWidget extends StatefulWidget {
  const MenuHorizontalWidget({
    super.key,
    required this.image,
    this.menu,
    required this.userData,
    required this.gearOptions,
  });

  final String? image;
  final List<dynamic>? menu;
  final dynamic userData;
  final List<dynamic>? gearOptions;

  @override
  State<MenuHorizontalWidget> createState() => _MenuHorizontalWidgetState();
}

class _MenuHorizontalWidgetState extends State<MenuHorizontalWidget> {
  late MenuHorizontalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontalModel());

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).tsTertiary700,
            FlutterFlowTheme.of(context).tsPrimary800
          ],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(1.0, 0.0),
          end: AlignmentDirectional(-1.0, 0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 16.0, 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget!.image!,
                width: 200.0,
                height: 36.0,
                fit: BoxFit.scaleDown,
                alignment: Alignment(-1.0, 0.0),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: wrapWithModel(
                        model: _model.menuHorizontaOptionsPageModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuHorizontaOptionsPageWidget(
                          items: widget!.menu,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.menuHorizontalUserModel,
                    updateCallback: () => safeSetState(() {}),
                    child: MenuHorizontalUserWidget(
                      userData: widget!.userData!,
                      userOption: FFAppState().UserOptionsNutrindo,
                      gearOptions: widget!.gearOptions!,
                    ),
                  ),
                ),
              ],
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
