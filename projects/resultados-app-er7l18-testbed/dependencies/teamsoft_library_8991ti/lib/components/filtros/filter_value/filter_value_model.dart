import '/backend/schema/enums/enums.dart';
import '/components/filtros/drop_down_value/drop_down_value_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'filter_value_widget.dart' show FilterValueWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterValueModel extends FlutterFlowModel<FilterValueWidget> {
  ///  Local state fields for this component.

  String? initialValue = '';

  String? finalValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future updateComponent(BuildContext context) async {
    dynamic? returnDateRange;

    await showAlignedDialog(
      barrierColor: Colors.transparent,
      context: context,
      isGlobal: false,
      avoidOverflow: false,
      targetAnchor:
          AlignmentDirectional(-1.02, 7.1).resolve(Directionality.of(context)),
      followerAnchor:
          AlignmentDirectional(-1.0, 1.0).resolve(Directionality.of(context)),
      builder: (dialogContext) {
        return Material(
          color: Colors.transparent,
          child: DropDownValueWidget(
            type: widget!.type!,
            initialValue: initialValue,
            finalValue: finalValue,
          ),
        );
      },
    ).then((value) => returnDateRange = value);

    initialValue = getJsonField(
              returnDateRange,
              r'''$.initialValue''',
            ) !=
            null
        ? getJsonField(
            returnDateRange,
            r'''$.initialValue''',
          ).toString()
        : null;
    finalValue = getJsonField(
              returnDateRange,
              r'''$.finalValue''',
            ) !=
            null
        ? getJsonField(
            returnDateRange,
            r'''$.finalValue''',
          ).toString()
        : null;
  }
}
