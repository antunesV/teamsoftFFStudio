import '/backend/schema/enums/enums.dart';
import '/components/filtros/drop_down_multi_select/drop_down_multi_select_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'input_multi_select_widget.dart' show InputMultiSelectWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InputMultiSelectModel extends FlutterFlowModel<InputMultiSelectWidget> {
  ///  Local state fields for this component.

  List<dynamic> listSelected = [];
  void addToListSelected(dynamic item) => listSelected.add(item);
  void removeFromListSelected(dynamic item) => listSelected.remove(item);
  void removeAtIndexFromListSelected(int index) => listSelected.removeAt(index);
  void insertAtIndexInListSelected(int index, dynamic item) =>
      listSelected.insert(index, item);
  void updateListSelectedAtIndex(int index, Function(dynamic) updateFn) =>
      listSelected[index] = updateFn(listSelected[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future updateComponent(BuildContext context) async {
    List<dynamic>? returnMultiSelec;
    List<dynamic>? returnMultiSelect;

    if (widget!.isBottomSheet) {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: DropDownMultiSelectWidget(
              list: widget!.list!,
              fieldName: widget!.fieldName,
              hasSearch: widget!.hasSearch,
              itemSpace: widget!.itemSpace,
              paddingTop: widget!.paddingTop,
              addable: widget!.addable,
              variant: widget!.variant!,
              fieldId: widget!.fieldId,
              listSelected: listSelected,
              isBottomSheet: true,
            ),
          );
        },
      ).then((value) => returnMultiSelec = value);

      if (returnMultiSelec != null && (returnMultiSelec)!.isNotEmpty) {
        listSelected = returnMultiSelec!.toList().cast<dynamic>();
      } else {
        listSelected = [];
      }
    } else {
      await showAlignedDialog(
        barrierColor: Colors.transparent,
        context: context,
        isGlobal: false,
        avoidOverflow: true,
        targetAnchor:
            AlignmentDirectional(-1.0, 1.0).resolve(Directionality.of(context)),
        followerAnchor: AlignmentDirectional(-1.0, -1.0)
            .resolve(Directionality.of(context)),
        builder: (dialogContext) {
          return Material(
            color: Colors.transparent,
            child: DropDownMultiSelectWidget(
              list: widget!.list!,
              fieldId: widget!.fieldId,
              fieldName: widget!.fieldName,
              listSelected: listSelected,
              hasSearch: widget!.hasSearch,
              itemSpace: widget!.itemSpace,
              paddingTop: widget!.paddingTop,
              addable: widget!.addable,
              variant: widget!.variant!,
            ),
          );
        },
      ).then((value) => returnMultiSelect = value);

      if (returnMultiSelect != null && (returnMultiSelect)!.isNotEmpty) {
        listSelected = returnMultiSelect!.toList().cast<dynamic>();
      } else {
        listSelected = [];
      }
    }
  }
}
