import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_item/menu_item_widget.dart';
import '/components/menu/modal_collapsed_menu_option/modal_collapsed_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'menu_item_widget.dart' show MenuItemWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuItemModel extends FlutterFlowModel<MenuItemWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // Models for menuItem dynamic component.
  FlutterFlowDynamicModels<MenuItemModel>? _menuItemModels1;
  FlutterFlowDynamicModels<MenuItemModel> get menuItemModels1 =>
      _menuItemModels1 ??= FlutterFlowDynamicModels(() => MenuItemModel());

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // Models for menuItem dynamic component.
  FlutterFlowDynamicModels<MenuItemModel>? _menuItemModels2;
  FlutterFlowDynamicModels<MenuItemModel> get menuItemModels2 =>
      _menuItemModels2 ??= FlutterFlowDynamicModels(() => MenuItemModel());

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController1.dispose();
    menuItemModels1.dispose();
    expandableExpandableController2.dispose();
    menuItemModels2.dispose();
  }
}
