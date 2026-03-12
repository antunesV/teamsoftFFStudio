import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'drop_down_calendar_model.dart';
export 'drop_down_calendar_model.dart';

class DropDownCalendarWidget extends StatefulWidget {
  const DropDownCalendarWidget({
    super.key,
    required this.type,
    this.initialDate,
    this.finalDate,
    this.width,
    this.variant,
    bool? isBottomSheet,
  }) : this.isBottomSheet = isBottomSheet ?? false;

  final TypeCalendar? type;
  final String? initialDate;
  final String? finalDate;
  final double? width;
  final Variant? variant;
  final bool isBottomSheet;

  @override
  State<DropDownCalendarWidget> createState() => _DropDownCalendarWidgetState();
}

class _DropDownCalendarWidgetState extends State<DropDownCalendarWidget> {
  late DropDownCalendarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownCalendarModel());

    _model.initialDateTextController ??=
        TextEditingController(text: widget!.initialDate);
    _model.initialDateFocusNode ??= FocusNode();

    _model.initialDateMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.finalDateTextController ??=
        TextEditingController(text: widget!.finalDate);
    _model.finalDateFocusNode ??= FocusNode();

    _model.finalDateMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.exactInitialDateTextController ??=
        TextEditingController(text: widget!.initialDate);
    _model.exactInitialDateFocusNode ??= FocusNode();

    _model.exactInitialDateMask = MaskTextInputFormatter(mask: '##/##/####');
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget!.width,
      constraints: BoxConstraints(
        maxWidth: 396.0,
      ),
      decoration: BoxDecoration(
        color: widget!.variant == Variant.dark
            ? Color(0xFF1F1F1F)
            : FlutterFlowTheme.of(context).tsNeutral0,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(valueOrDefault<double>(
            widget!.isBottomSheet ? 0.0 : 12.0,
            0.0,
          )),
          bottomRight: Radius.circular(valueOrDefault<double>(
            widget!.isBottomSheet ? 0.0 : 12.0,
            0.0,
          )),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        border: Border.all(
          color: widget!.variant == Variant.dark
              ? FlutterFlowTheme.of(context).tsNeutral800
              : FlutterFlowTheme.of(context).tsNeutral200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget!.type == TypeCalendar.interval)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: 170.0,
                          decoration: BoxDecoration(
                            color: widget!.variant == Variant.dark
                                ? FlutterFlowTheme.of(context).tsNeutral900
                                : Color(0x00000000),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: widget!.variant == Variant.dark
                                  ? Color(0xFF333333)
                                  : FlutterFlowTheme.of(context).tsNeutral300,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: FocusTraversalOrder(
                                  order: const NumericFocusOrder(1000.0),
                                  child: Container(
                                    width: 200.0,
                                    child: TextFormField(
                                      controller:
                                          _model.initialDateTextController,
                                      focusNode: _model.initialDateFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.initialDateTextController',
                                        Duration(milliseconds: 2000),
                                        () async {},
                                      ),
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? Color(0xFFA6A6A6)
                                                  : FlutterFlowTheme.of(context)
                                                      .tsNeutral700,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                            ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          'tveef0qy' /* DD/MM/AAAA */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? Color(0xFFA6A6A6)
                                                  : FlutterFlowTheme.of(context)
                                                      .tsNeutral700,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .tsNeutral700,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .tsDanger300,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .tsDanger300,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor:
                                            widget!.variant == Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsNeutral900
                                                : FlutterFlowTheme.of(context)
                                                    .tsNeutral0,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .tsFontNormalSm
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                            ),
                                            color: widget!.variant ==
                                                    Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsTextInverter
                                                : FlutterFlowTheme.of(context)
                                                    .tsTextDefault,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .tsFontNormalSm
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .tsFontNormalSm
                                                    .fontStyle,
                                          ),
                                      maxLength: 10,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      buildCounter: (context,
                                              {required currentLength,
                                              required isFocused,
                                              maxLength}) =>
                                          null,
                                      cursorColor:
                                          widget!.variant == Variant.dark
                                              ? FlutterFlowTheme.of(context)
                                                  .tsTextInverter
                                              : FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                      validator: _model
                                          .initialDateTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [_model.initialDateMask],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  final _datePicked1Date = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        ((widget!.initialDate != null &&
                                                    widget!.initialDate != ''
                                                ? functions.stringToDate(
                                                    widget!.initialDate!, '')
                                                : getCurrentTimestamp) ??
                                            DateTime.now()),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsPrimaryDefault,
                                        headerForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsTextInverter,
                                        headerTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .tsFontNormalBase
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsTextDefault,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalBase
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalBase
                                                      .fontStyle,
                                            ),
                                        pickerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsNeutral0,
                                        pickerForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsTextDefault,
                                        selectedDateTimeBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsPrimaryDefault,
                                        selectedDateTimeForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsNeutral0,
                                        actionButtonForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tsTextDefault,
                                        iconSize: 24.0,
                                      );
                                    },
                                  );

                                  if (_datePicked1Date != null) {
                                    safeSetState(() {
                                      _model.datePicked1 = DateTime(
                                        _datePicked1Date.year,
                                        _datePicked1Date.month,
                                        _datePicked1Date.day,
                                      );
                                    });
                                  } else if (_model.datePicked1 != null) {
                                    safeSetState(() {
                                      _model.datePicked1 =
                                          (widget!.initialDate != null &&
                                                  widget!.initialDate != ''
                                              ? functions.stringToDate(
                                                  widget!.initialDate!, '')
                                              : getCurrentTimestamp);
                                    });
                                  }
                                  safeSetState(() {
                                    _model.initialDateTextController?.text =
                                        dateTimeFormat(
                                      "dd/MM/yyyy",
                                      functions.timestampToDateTime(_model
                                          .datePicked1?.secondsSinceEpoch),
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    );
                                    _model.initialDateFocusNode?.requestFocus();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _model.initialDateTextController
                                          ?.selection = TextSelection.collapsed(
                                        offset: _model
                                            .initialDateTextController!
                                            .text
                                            .length,
                                      );
                                    });
                                    _model.initialDateMask.updateMask(
                                      newValue: TextEditingValue(
                                        text: _model
                                            .initialDateTextController!.text,
                                        selection: TextSelection.collapsed(
                                          offset: _model
                                              .initialDateTextController!
                                              .text
                                              .length,
                                        ),
                                      ),
                                    );
                                  });
                                  if (_model.initialDateTextController.text !=
                                          null &&
                                      _model.initialDateTextController.text !=
                                          '') {}
                                },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Icon(
                                    FFIcons.kcalendarBlank,
                                    color: widget!.variant == Variant.dark
                                        ? FlutterFlowTheme.of(context)
                                            .tsTextInverter
                                        : FlutterFlowTheme.of(context)
                                            .tsTextDefault,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget!.type == TypeCalendar.interval)
                        Text(
                          FFLocalizations.of(context).getText(
                            'z89r93cz' /* até */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .tsFontNormalSm
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .fontStyle,
                                ),
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context)
                                        .tsTextInverter
                                    : FlutterFlowTheme.of(context)
                                        .tsTextDefault,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .tsFontNormalSm
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontNormalSm
                                    .fontStyle,
                              ),
                        ),
                      if (widget!.type == TypeCalendar.interval)
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: 170.0,
                            decoration: BoxDecoration(
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsNeutral900
                                  : Color(0x00000000),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: widget!.variant == Variant.dark
                                    ? Color(0xFF333333)
                                    : FlutterFlowTheme.of(context).tsNeutral300,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: FocusTraversalOrder(
                                    order: const NumericFocusOrder(1001.0),
                                    child: Container(
                                      width: 200.0,
                                      child: TextFormField(
                                        controller:
                                            _model.finalDateTextController,
                                        focusNode: _model.finalDateFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.finalDateTextController',
                                          Duration(milliseconds: 2000),
                                          () async {},
                                        ),
                                        onFieldSubmitted: (_) async {
                                          Navigator.pop(
                                              context, <String, DateTime?>{
                                            'initialDate': functions.stringToDate(
                                                _model.initialDateTextController
                                                    .text,
                                                ''),
                                            'finalDate': functions.stringToDate(
                                                _model.finalDateTextController
                                                                .text !=
                                                            null &&
                                                        _model.finalDateTextController
                                                                .text !=
                                                            ''
                                                    ? _model
                                                        .finalDateTextController
                                                        .text
                                                    : null!,
                                                ''),
                                          });
                                        },
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .tsFontNormalSm
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                                color: widget!.variant ==
                                                        Variant.dark
                                                    ? Color(0xFFA6A6A6)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral700,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                          hintText: FFLocalizations.of(context)
                                              .getText(
                                            'g9oyaei9' /* DD/MM/AAAA */,
                                          ),
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .tsFontNormalSm
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                                color: widget!.variant ==
                                                        Variant.dark
                                                    ? Color(0xFFA6A6A6)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .tsNeutral700,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsNeutral700,
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsDanger300,
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsDanger300,
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              widget!.variant == Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsNeutral900
                                                  : FlutterFlowTheme.of(context)
                                                      .tsNeutral0,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalSm
                                                        .fontStyle,
                                              ),
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsTextInverter
                                                  : FlutterFlowTheme.of(context)
                                                      .tsTextDefault,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                            ),
                                        maxLength: 10,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        buildCounter: (context,
                                                {required currentLength,
                                                required isFocused,
                                                maxLength}) =>
                                            null,
                                        cursorColor:
                                            widget!.variant == Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsTextInverter
                                                : FlutterFlowTheme.of(context)
                                                    .tsTextDefault,
                                        validator: _model
                                            .finalDateTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [_model.finalDateMask],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final _datePicked2Date =
                                        await showDatePicker(
                                      context: context,
                                      initialDate:
                                          ((widget!.finalDate != null &&
                                                      widget!.finalDate != ''
                                                  ? functions.stringToDate(
                                                      widget!.finalDate!, '')
                                                  : getCurrentTimestamp) ??
                                              DateTime.now()),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2050),
                                      builder: (context, child) {
                                        return wrapInMaterialDatePickerTheme(
                                          context,
                                          child!,
                                          headerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsPrimaryDefault,
                                          headerForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsTextInverter,
                                          headerTextStyle: FlutterFlowTheme.of(
                                                  context)
                                              .tsFontNormalBase
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalBase
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalBase
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tsTextDefault,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .fontStyle,
                                              ),
                                          pickerBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsNeutral0,
                                          pickerForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                          selectedDateTimeBackgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsPrimaryDefault,
                                          selectedDateTimeForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsNeutral50,
                                          actionButtonForegroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tsTextDefault,
                                          iconSize: 24.0,
                                        );
                                      },
                                    );

                                    if (_datePicked2Date != null) {
                                      safeSetState(() {
                                        _model.datePicked2 = DateTime(
                                          _datePicked2Date.year,
                                          _datePicked2Date.month,
                                          _datePicked2Date.day,
                                        );
                                      });
                                    } else if (_model.datePicked2 != null) {
                                      safeSetState(() {
                                        _model.datePicked2 =
                                            (widget!.finalDate != null &&
                                                    widget!.finalDate != ''
                                                ? functions.stringToDate(
                                                    widget!.finalDate!, '')
                                                : getCurrentTimestamp);
                                      });
                                    }
                                    safeSetState(() {
                                      _model.finalDateTextController?.text =
                                          dateTimeFormat(
                                        "dd/MM/yyyy",
                                        functions.timestampToDateTime(_model
                                            .datePicked2?.secondsSinceEpoch),
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      );
                                      _model.finalDateFocusNode?.requestFocus();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        _model.finalDateTextController
                                                ?.selection =
                                            TextSelection.collapsed(
                                          offset: _model
                                              .finalDateTextController!
                                              .text
                                              .length,
                                        );
                                      });
                                      _model.finalDateMask.updateMask(
                                        newValue: TextEditingValue(
                                          text: _model
                                              .finalDateTextController!.text,
                                          selection: TextSelection.collapsed(
                                            offset: _model
                                                .finalDateTextController!
                                                .text
                                                .length,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Icon(
                                      FFIcons.kcalendarBlank,
                                      color: widget!.variant == Variant.dark
                                          ? FlutterFlowTheme.of(context)
                                              .tsTextInverter
                                          : FlutterFlowTheme.of(context)
                                              .tsTextDefault,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                if (widget!.type == TypeCalendar.exact)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: widget!.variant == Variant.dark
                                        ? FlutterFlowTheme.of(context)
                                            .tsNeutral900
                                        : Color(0x00000000),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: widget!.variant == Variant.dark
                                          ? Color(0xFF333333)
                                          : FlutterFlowTheme.of(context)
                                              .tsNeutral300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: FocusTraversalOrder(
                                          order:
                                              const NumericFocusOrder(1000.0),
                                          child: TextFormField(
                                            controller: _model
                                                .exactInitialDateTextController,
                                            focusNode: _model
                                                .exactInitialDateFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.exactInitialDateTextController',
                                              Duration(milliseconds: 2000),
                                              () async {},
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .tsFontNormalSm
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontNormalSm
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontNormalSm
                                                              .fontStyle,
                                                    ),
                                                    color: widget!.variant ==
                                                            Variant.dark
                                                        ? Color(0xFFA6A6A6)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral700,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontStyle,
                                                  ),
                                              hintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'wj6g6qiu' /* DD/MM/AAAA */,
                                              ),
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .tsFontNormalSm
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontNormalSm
                                                              .fontStyle,
                                                    ),
                                                    color: widget!.variant ==
                                                            Variant.dark
                                                        ? Color(0xFFA6A6A6)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral700,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontStyle,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsNeutral700,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsDanger300,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tsDanger300,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor: widget!.variant ==
                                                      Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsNeutral900
                                                  : FlutterFlowTheme.of(context)
                                                      .tsNeutral0,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .tsFontNormalSm
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontStyle,
                                                  ),
                                                  color: widget!.variant ==
                                                          Variant.dark
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .tsTextInverter
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .tsTextDefault,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                            maxLength: 10,
                                            maxLengthEnforcement:
                                                MaxLengthEnforcement.enforced,
                                            buildCounter: (context,
                                                    {required currentLength,
                                                    required isFocused,
                                                    maxLength}) =>
                                                null,
                                            cursorColor: widget!.variant ==
                                                    Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsTextInverter
                                                : FlutterFlowTheme.of(context)
                                                    .tsTextDefault,
                                            validator: _model
                                                .exactInitialDateTextControllerValidator
                                                .asValidator(context),
                                            inputFormatters: [
                                              _model.exactInitialDateMask
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final _datePicked3Date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: ((widget!
                                                                .initialDate !=
                                                            null &&
                                                        widget!.initialDate !=
                                                            ''
                                                    ? functions.stringToDate(
                                                        widget!.initialDate!,
                                                        '')
                                                    : getCurrentTimestamp) ??
                                                DateTime.now()),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2050),
                                            builder: (context, child) {
                                              return wrapInMaterialDatePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsPrimaryDefault,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsTextInverter,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .tsFontNormalBase
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalBase
                                                                    .fontWeight,
                                                            fontStyle: FlutterFlowTheme
                                                                    .of(context)
                                                                .tsFontNormalBase
                                                                .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tsTextDefault,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalBase
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalBase
                                                                  .fontStyle,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsNeutral0,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsTextDefault,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsPrimaryDefault,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsNeutral50,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tsTextDefault,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );

                                          if (_datePicked3Date != null) {
                                            safeSetState(() {
                                              _model.datePicked3 = DateTime(
                                                _datePicked3Date.year,
                                                _datePicked3Date.month,
                                                _datePicked3Date.day,
                                              );
                                            });
                                          } else if (_model.datePicked3 !=
                                              null) {
                                            safeSetState(() {
                                              _model.datePicked3 = (widget!
                                                              .initialDate !=
                                                          null &&
                                                      widget!.initialDate != ''
                                                  ? functions.stringToDate(
                                                      widget!.initialDate!, '')
                                                  : getCurrentTimestamp);
                                            });
                                          }
                                          safeSetState(() {
                                            _model
                                                .exactInitialDateTextController
                                                ?.text = dateTimeFormat(
                                              "dd/MM/yyyy",
                                              functions.timestampToDateTime(
                                                  _model.datePicked3
                                                      ?.secondsSinceEpoch),
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            );
                                            _model.exactInitialDateFocusNode
                                                ?.requestFocus();
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              _model.exactInitialDateTextController
                                                      ?.selection =
                                                  TextSelection.collapsed(
                                                offset: _model
                                                    .exactInitialDateTextController!
                                                    .text
                                                    .length,
                                              );
                                            });
                                            _model.exactInitialDateMask
                                                .updateMask(
                                              newValue: TextEditingValue(
                                                text: _model
                                                    .exactInitialDateTextController!
                                                    .text,
                                                selection:
                                                    TextSelection.collapsed(
                                                  offset: _model
                                                      .exactInitialDateTextController!
                                                      .text
                                                      .length,
                                                ),
                                              ),
                                            );
                                          });
                                          if (_model.exactInitialDateTextController
                                                      .text !=
                                                  null &&
                                              _model.exactInitialDateTextController
                                                      .text !=
                                                  '') {}
                                        },
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0.0),
                                              bottomRight: Radius.circular(8.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Icon(
                                            FFIcons.kcalendarBlank,
                                            color: widget!.variant ==
                                                    Variant.dark
                                                ? FlutterFlowTheme.of(context)
                                                    .tsTextInverter
                                                : FlutterFlowTheme.of(context)
                                                    .tsTextDefault,
                                            size: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (widget!.type == TypeCalendar.interval)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            'i058llk5' /* Limpar */,
                          ),
                          options: FFButtonOptions(
                            height: 36.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsPrimaryDefault,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (widget!.isBottomSheet) {
                              Navigator.pop(context, <String, DateTime?>{
                                'initialDate': functions.stringToDate(
                                    _model.initialDateTextController.text, ''),
                                'finalDate': functions.stringToDate(
                                    _model.finalDateTextController.text !=
                                                null &&
                                            _model.finalDateTextController
                                                    .text !=
                                                ''
                                        ? _model.finalDateTextController.text
                                        : null!,
                                    ''),
                              });
                            } else {
                              Navigator.pop(context, <String, DateTime?>{
                                'initialDate': functions.stringToDate(
                                    _model.initialDateTextController.text, ''),
                                'finalDate': functions.stringToDate(
                                    _model.finalDateTextController.text !=
                                                null &&
                                            _model.finalDateTextController
                                                    .text !=
                                                ''
                                        ? _model.finalDateTextController.text
                                        : null!,
                                    ''),
                              });
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            't221e2wn' /* Aplicar */,
                          ),
                          options: FFButtonOptions(
                            height: 36.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).tsPrimaryDefault,
                            textStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                                  color: widget!.variant == Variant.dark
                                      ? FlutterFlowTheme.of(context)
                                          .tsTextDefault
                                      : FlutterFlowTheme.of(context)
                                          .tsTextInverter,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ],
                    ),
                  ),
                if (widget!.type == TypeCalendar.exact)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            'z75gcdwg' /* Limpar */,
                          ),
                          options: FFButtonOptions(
                            height: 36.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .tsPrimaryDefault,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (widget!.isBottomSheet) {
                              Navigator.pop(context, <String, DateTime?>{
                                'initialDate': functions.stringToDate(
                                    _model.exactInitialDateTextController.text,
                                    ''),
                                'finalDate': null,
                              });
                            } else {
                              Navigator.pop(context, <String, DateTime?>{
                                'initialDate': functions.stringToDate(
                                    _model.exactInitialDateTextController.text,
                                    ''),
                                'finalDate': null,
                              });
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            '6jkwde8h' /* Aplicar */,
                          ),
                          options: FFButtonOptions(
                            height: 36.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).tsPrimaryDefault,
                            textStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                                  color: widget!.variant == Variant.dark
                                      ? FlutterFlowTheme.of(context)
                                          .tsTextDefault
                                      : FlutterFlowTheme.of(context)
                                          .tsTextInverter,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ].divide(SizedBox(width: 24.0)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
