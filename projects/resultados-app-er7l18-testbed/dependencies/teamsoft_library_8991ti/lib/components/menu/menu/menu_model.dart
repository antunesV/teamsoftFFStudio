import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_footer/menu_footer_widget.dart';
import '/components/menu/menu_header/menu_header_widget.dart';
import '/components/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'menu_widget.dart' show MenuWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuModel extends FlutterFlowModel<MenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getCurrentPage] action in menu widget.
  String? currentPage;
  // Model for menuHeader component.
  late MenuHeaderModel menuHeaderModel;
  // Models for menuItem dynamic component.
  FlutterFlowDynamicModels<MenuItemModel>? _menuItemModels;
  FlutterFlowDynamicModels<MenuItemModel> get menuItemModels =>
      _menuItemModels ??= FlutterFlowDynamicModels(() => MenuItemModel());

  // Model for menuFooter component.
  late MenuFooterModel menuFooterModel;

  @override
  void initState(BuildContext context) {
    menuHeaderModel = createModel(context, () => MenuHeaderModel());
    menuFooterModel = createModel(context, () => MenuFooterModel());
  }

  @override
  void dispose() {
    menuHeaderModel.dispose();
    menuItemModels.dispose();
    menuFooterModel.dispose();
  }
}
