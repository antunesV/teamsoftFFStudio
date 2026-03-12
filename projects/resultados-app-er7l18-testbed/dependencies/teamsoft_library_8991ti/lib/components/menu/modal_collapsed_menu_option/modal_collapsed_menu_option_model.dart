import '/backend/schema/enums/enums.dart';
import '/components/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'modal_collapsed_menu_option_widget.dart'
    show ModalCollapsedMenuOptionWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalCollapsedMenuOptionModel
    extends FlutterFlowModel<ModalCollapsedMenuOptionWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for menuItem dynamic component.
  FlutterFlowDynamicModels<MenuItemModel>? _menuItemModels;
  FlutterFlowDynamicModels<MenuItemModel> get menuItemModels =>
      _menuItemModels ??= FlutterFlowDynamicModels(() => MenuItemModel());

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    menuItemModels.dispose();
  }
}
