import '/backend/schema/enums/enums.dart';
import '/components/filtros/drop_down_single_select/drop_down_single_select_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'input_single_select_widget.dart' show InputSingleSelectWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InputSingleSelectModel extends FlutterFlowModel<InputSingleSelectWidget> {
  ///  Local state fields for this component.

  dynamic listSelected;

  dynamic returnSingleSelect;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future updateComponent(BuildContext context) async {
    dynamic? returnSingleSelectBottomSheet;
    dynamic? returnSingleSelectCustomDialog;

    if (widget!.isBottomSheet) {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: DropDownSingleSelectWidget(
              list: widget!.list!,
              fieldName: widget!.fieldName,
              hasSearch: widget!.hasSearch,
              unlink: widget!.unlink,
              paddingTop: widget!.paddingTop,
              addable: widget!.addable,
              fieldId: widget!.fieldId,
              fieldDescription: widget!.fieldDescription,
              fieldImage: widget!.fieldImage,
              width: widget!.width,
              insideHeight: widget!.insideHeight,
              itemSpace: widget!.itemSpace,
              isBottomsheet: widget!.isBottomSheet,
              maxCharacters: widget!.maxCharacters,
              textUnlink: widget!.textUnlink,
              variant: widget!.variant,
              hasTitleText: widget!.hasTitle,
              titleText: widget!.titleText,
              colorText: widget!.colorText,
              callbackAdd: (name) async {},
            ),
          );
        },
      ).then((value) => returnSingleSelectBottomSheet = value);

      returnSingleSelect = returnSingleSelectBottomSheet;
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
            child: DropDownSingleSelectWidget(
              list: widget!.list!,
              fieldName: widget!.fieldName,
              hasSearch: widget!.hasSearch,
              fieldId: widget!.fieldId,
              unlink: widget!.unlink,
              width: widget!.width,
              insideHeight: widget!.insideHeight,
              itemSpace: widget!.itemSpace,
              paddingTop: widget!.paddingTop,
              addable: widget!.addable,
              isBottomsheet: widget!.isBottomSheet,
              maxCharacters: widget!.maxCharacters,
              textUnlink: widget!.textUnlink,
              variant: widget!.variant,
              titleText: widget!.titleText,
              hasTitleText: widget!.hasTitle,
              colorText: widget!.colorText,
              callbackAdd: (name) async {},
            ),
          );
        },
      ).then((value) => returnSingleSelectCustomDialog = value);

      returnSingleSelect = returnSingleSelectCustomDialog;
    }

    if (getJsonField(
          returnSingleSelect,
          r'''$.reset''',
        ) ==
        getJsonField(
          <String, bool?>{
            'value': true,
          },
          r'''$.value''',
        )) {
      listSelected = null;
    } else if (returnSingleSelect != null) {
      listSelected = returnSingleSelect;
    }
  }
}
