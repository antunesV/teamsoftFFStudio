import '/components/menu/horizontal/menu_horizonta_options_page/menu_horizonta_options_page_widget.dart';
import '/components/menu/horizontal/menu_horizontal_user/menu_horizontal_user_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'menu_horizontal_widget.dart' show MenuHorizontalWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuHorizontalModel extends FlutterFlowModel<MenuHorizontalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for menuHorizontaOptionsPage component.
  late MenuHorizontaOptionsPageModel menuHorizontaOptionsPageModel;
  // Model for menuHorizontalUser component.
  late MenuHorizontalUserModel menuHorizontalUserModel;

  @override
  void initState(BuildContext context) {
    menuHorizontaOptionsPageModel =
        createModel(context, () => MenuHorizontaOptionsPageModel());
    menuHorizontalUserModel =
        createModel(context, () => MenuHorizontalUserModel());
  }

  @override
  void dispose() {
    menuHorizontaOptionsPageModel.dispose();
    menuHorizontalUserModel.dispose();
  }
}
