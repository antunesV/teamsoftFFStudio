import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_date_model.dart';
export 'input_date_model.dart';

class InputDateWidget extends StatefulWidget {
  const InputDateWidget({
    super.key,
    this.initialDate,
    this.getValue,
  });

  final DateTime? initialDate;
  final Future Function(String? value)? getValue;

  @override
  State<InputDateWidget> createState() => _InputDateWidgetState();
}

class _InputDateWidgetState extends State<InputDateWidget> {
  late InputDateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputDateModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.initialDate != null) {
        safeSetState(() {
          _model.exactInitialDateTextController?.text =
              functions.dateFormat(_model.exactInitialDateTextController.text)!;
        });
      }
    });

    _model.exactInitialDateTextController ??= TextEditingController();
    _model.exactInitialDateFocusNode ??= FocusNode();
    _model.exactInitialDateFocusNode!.addListener(
      () async {
        await widget.getValue?.call(
          _model.exactInitialDateTextController.text,
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {
          _model.exactInitialDateTextController?.text = dateTimeFormat(
            "dd/MM/yyyy",
            widget!.initialDate,
            locale: FFLocalizations.of(context).languageCode,
          );
        }));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tsNeutral0,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).tsNeutral300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: FocusTraversalOrder(
                    order: const NumericFocusOrder(1000.0),
                    child: TextFormField(
                      controller: _model.exactInitialDateTextController,
                      focusNode: _model.exactInitialDateFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.exactInitialDateTextController',
                        Duration(milliseconds: 0),
                        () async {
                          safeSetState(() {
                            _model.exactInitialDateTextController?.text =
                                functions.dateOnChange(_model
                                    .exactInitialDateTextController.text)!;
                            _model.exactInitialDateFocusNode?.requestFocus();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _model.exactInitialDateTextController?.selection =
                                  TextSelection.collapsed(
                                offset: _model.exactInitialDateTextController!
                                    .text.length,
                              );
                            });
                          });
                        },
                      ),
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle: FlutterFlowTheme.of(context)
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
                              color: FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontStyle,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          '3a5lk26i' /* DD/MM/AAAA */,
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .tsFontNormalSm
                            .override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontNormalSm
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).tsNeutral700,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontStyle,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.of(context).tsNeutral0,
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
                            color: FlutterFlowTheme.of(context).tsTextDefault,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontNormalSm
                                .fontStyle,
                          ),
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          null,
                      keyboardType: TextInputType.datetime,
                      cursorColor: FlutterFlowTheme.of(context).tsTextDefault,
                      validator: _model.exactInitialDateTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final _datePickedDate = await showDatePicker(
                      context: context,
                      initialDate: ((widget!.initialDate != null
                              ? widget!.initialDate
                              : getCurrentTimestamp) ??
                          DateTime.now()),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2050),
                      builder: (context, child) {
                        return wrapInMaterialDatePickerTheme(
                          context,
                          child!,
                          headerBackgroundColor:
                              FlutterFlowTheme.of(context).tsPrimaryDefault,
                          headerForegroundColor:
                              FlutterFlowTheme.of(context).tsNeutral0,
                          headerTextStyle: FlutterFlowTheme.of(context)
                              .tsFontNormalBase
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .tsFontNormalBase
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalBase
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).tsTextDefault,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .tsFontNormalBase
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontNormalBase
                                    .fontStyle,
                              ),
                          pickerBackgroundColor:
                              FlutterFlowTheme.of(context).tsNeutral0,
                          pickerForegroundColor:
                              FlutterFlowTheme.of(context).tsTextDefault,
                          selectedDateTimeBackgroundColor:
                              FlutterFlowTheme.of(context).tsPrimaryDefault,
                          selectedDateTimeForegroundColor:
                              FlutterFlowTheme.of(context).tsNeutral0,
                          actionButtonForegroundColor:
                              FlutterFlowTheme.of(context).tsTextDefault,
                          iconSize: 24.0,
                        );
                      },
                    );

                    if (_datePickedDate != null) {
                      safeSetState(() {
                        _model.datePicked = DateTime(
                          _datePickedDate.year,
                          _datePickedDate.month,
                          _datePickedDate.day,
                        );
                      });
                    } else if (_model.datePicked != null) {
                      safeSetState(() {
                        _model.datePicked = (widget!.initialDate != null
                            ? widget!.initialDate
                            : getCurrentTimestamp);
                      });
                    }
                    safeSetState(() {
                      _model.exactInitialDateTextController?.text =
                          dateTimeFormat(
                        "dd/MM/yyyy",
                        functions.timestampToDateTime(
                            _model.datePicked?.secondsSinceEpoch),
                        locale: FFLocalizations.of(context).languageCode,
                      );
                    });
                    await widget.getValue?.call(
                      _model.exactInitialDateTextController.text,
                    );
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tsNeutral0,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(8.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Icon(
                      FFIcons.kcalendarBlank,
                      color: FlutterFlowTheme.of(context).tsTextDefault,
                      size: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
