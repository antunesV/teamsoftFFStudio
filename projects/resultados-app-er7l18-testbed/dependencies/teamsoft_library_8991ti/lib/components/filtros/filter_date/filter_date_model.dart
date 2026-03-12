import '/backend/schema/enums/enums.dart';
import '/components/filtros/drop_down_calendar/drop_down_calendar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'filter_date_widget.dart' show FilterDateWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterDateModel extends FlutterFlowModel<FilterDateWidget> {
  ///  Local state fields for this component.

  String? initialDate = '';

  String? finalDate;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future updateComponent(BuildContext context) async {
    dynamic? returnDateRang;
    dynamic? returnDateRange;

    if (widget!.isBottomSheet) {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: DropDownCalendarWidget(
              type: widget!.type!,
              initialDate: initialDate,
              finalDate: finalDate,
              width: widget!.width,
              variant: widget!.variant,
              isBottomSheet: true,
            ),
          );
        },
      ).then((value) => returnDateRang = value);

      initialDate = getJsonField(
                returnDateRang,
                r'''$.initialDate''',
              ) !=
              null
          ? functions.dateTimeToDate(getJsonField(
              returnDateRang,
              r'''$.initialDate''',
            ).toString())
          : null;
      finalDate = getJsonField(
                returnDateRang,
                r'''$.finalDate''',
              ) !=
              null
          ? functions.dateTimeToDate(getJsonField(
              returnDateRang,
              r'''$.finalDate''',
            ).toString())
          : null;
    } else {
      await showAlignedDialog(
        barrierColor: Colors.transparent,
        context: context,
        isGlobal: false,
        avoidOverflow: true,
        targetAnchor: AlignmentDirectional(-1.02, 7.1)
            .resolve(Directionality.of(context)),
        followerAnchor:
            AlignmentDirectional(-1.0, 1.0).resolve(Directionality.of(context)),
        builder: (dialogContext) {
          return Material(
            color: Colors.transparent,
            child: DropDownCalendarWidget(
              type: widget!.type!,
              initialDate: initialDate,
              finalDate: finalDate,
              width: widget!.width,
              variant: widget!.variant,
            ),
          );
        },
      ).then((value) => returnDateRange = value);

      initialDate = getJsonField(
                returnDateRange,
                r'''$.initialDate''',
              ) !=
              null
          ? functions.dateTimeToDate(getJsonField(
              returnDateRange,
              r'''$.initialDate''',
            ).toString())
          : null;
      finalDate = getJsonField(
                returnDateRange,
                r'''$.finalDate''',
              ) !=
              null
          ? functions.dateTimeToDate(getJsonField(
              returnDateRange,
              r'''$.finalDate''',
            ).toString())
          : null;
    }
  }
}
