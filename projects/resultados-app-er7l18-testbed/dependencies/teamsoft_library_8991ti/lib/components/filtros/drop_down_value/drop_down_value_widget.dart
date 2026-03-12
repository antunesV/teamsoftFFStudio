import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drop_down_value_model.dart';
export 'drop_down_value_model.dart';

class DropDownValueWidget extends StatefulWidget {
  const DropDownValueWidget({
    super.key,
    required this.type,
    this.initialValue,
    this.finalValue,
  });

  final TypeCalendar? type;
  final String? initialValue;
  final String? finalValue;

  @override
  State<DropDownValueWidget> createState() => _DropDownValueWidgetState();
}

class _DropDownValueWidgetState extends State<DropDownValueWidget> {
  late DropDownValueModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownValueModel());

    _model.inicialValueTextController ??=
        TextEditingController(text: widget!.initialValue);
    _model.inicialValueFocusNode ??= FocusNode();

    _model.finalValueTextController ??=
        TextEditingController(text: widget!.finalValue);
    _model.finalValueFocusNode ??= FocusNode();

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
      width: 376.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tsNeutral0,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).tsNeutral200,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 170.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tsNeutral300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 41.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tsNeutral50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '6cckoxlc' /* R$ */,
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
                                    color: FlutterFlowTheme.of(context)
                                        .tsNeutral600,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 41.0,
                        child: VerticalDivider(
                          width: 1.0,
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).tsNeutral300,
                        ),
                      ),
                      Expanded(
                        child: FocusTraversalOrder(
                          order: const NumericFocusOrder(1000.0),
                          child: Container(
                            width: 200.0,
                            child: TextFormField(
                              controller: _model.inicialValueTextController,
                              focusNode: _model.inicialValueFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.inicialValueTextController',
                                Duration(milliseconds: 0),
                                () async {
                                  safeSetState(() {
                                    _model.inicialValueTextController?.text =
                                        functions.formateValueToReal(_model
                                            .inicialValueTextController.text)!;
                                    _model.inicialValueFocusNode
                                        ?.requestFocus();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _model.inicialValueTextController
                                          ?.selection = TextSelection.collapsed(
                                        offset: _model
                                            .inicialValueTextController!
                                            .text
                                            .length,
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
                                      color: FlutterFlowTheme.of(context)
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
                                hintText: FFLocalizations.of(context).getText(
                                  'aggzgt7i' /* De */,
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
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral700,
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
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    FlutterFlowTheme.of(context).tsNeutral0,
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
                                    color: FlutterFlowTheme.of(context)
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
                              maxLength: 10,
                              maxLengthEnforcement: MaxLengthEnforcement.none,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              keyboardType: TextInputType.number,
                              cursorColor:
                                  FlutterFlowTheme.of(context).tsTextDefault,
                              validator: _model
                                  .inicialValueTextControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget!.type == TypeCalendar.interval)
                  Container(
                    width: 170.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).tsNeutral300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 41.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tsNeutral50,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(0.0),
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '3cflorl7' /* R$ */,
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
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral600,
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 41.0,
                          child: VerticalDivider(
                            width: 1.0,
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).tsNeutral300,
                          ),
                        ),
                        Expanded(
                          child: FocusTraversalOrder(
                            order: const NumericFocusOrder(1001.0),
                            child: Container(
                              width: 200.0,
                              child: TextFormField(
                                controller: _model.finalValueTextController,
                                focusNode: _model.finalValueFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.finalValueTextController',
                                  Duration(milliseconds: 0),
                                  () async {
                                    safeSetState(() {
                                      _model.finalValueTextController?.text =
                                          functions.formateValueToReal(_model
                                              .finalValueTextController.text)!;
                                      _model.finalValueFocusNode
                                          ?.requestFocus();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        _model.finalValueTextController
                                                ?.selection =
                                            TextSelection.collapsed(
                                          offset: _model
                                              .finalValueTextController!
                                              .text
                                              .length,
                                        );
                                      });
                                    });
                                  },
                                ),
                                onFieldSubmitted: (_) async {
                                  Navigator.pop(context, <String, DateTime?>{
                                    'initialDate': functions.stringToDate(
                                        _model.inicialValueTextController.text,
                                        ''),
                                    'finalDate': functions.stringToDate(
                                        _model.finalValueTextController.text !=
                                                    null &&
                                                _model.finalValueTextController
                                                        .text !=
                                                    ''
                                            ? _model
                                                .finalValueTextController.text
                                            : null!,
                                        ''),
                                  });
                                },
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
                                        color: FlutterFlowTheme.of(context)
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
                                  hintText: FFLocalizations.of(context).getText(
                                    'e3rghydt' /* Até */,
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
                                        color: FlutterFlowTheme.of(context)
                                            .tsNeutral700,
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
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).tsNeutral0,
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
                                      color: FlutterFlowTheme.of(context)
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
                                keyboardType: TextInputType.number,
                                cursorColor:
                                    FlutterFlowTheme.of(context).tsTextDefault,
                                validator: _model
                                    .finalValueTextControllerValidator
                                    .asValidator(context),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context, null);
                  },
                  text: FFLocalizations.of(context).getText(
                    '3315kfl4' /* Limpar */,
                  ),
                  options: FFButtonOptions(
                    height: 36.0,
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                          color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldBase
                              .fontStyle,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  showLoadingIndicator: false,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context, <String, String?>{
                      'initialValue': _model.inicialValueTextController.text,
                      'finalValue': _model.finalValueTextController.text,
                    });
                  },
                  text: FFLocalizations.of(context).getText(
                    'qdfymf81' /* Aplicar */,
                  ),
                  options: FFButtonOptions(
                    height: 36.0,
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                    textStyle: FlutterFlowTheme.of(context)
                        .tsFontSemiboldBase
                        .override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).tsTextInverter,
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
        ],
      ),
    );
  }
}
