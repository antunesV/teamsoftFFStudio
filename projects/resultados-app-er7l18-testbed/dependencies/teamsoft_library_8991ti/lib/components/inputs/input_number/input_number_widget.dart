import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_number_model.dart';
export 'input_number_model.dart';

class InputNumberWidget extends StatefulWidget {
  const InputNumberWidget({
    super.key,
    int? initialNumber,
  }) : this.initialNumber = initialNumber ?? 0;

  final int initialNumber;

  @override
  State<InputNumberWidget> createState() => _InputNumberWidgetState();
}

class _InputNumberWidgetState extends State<InputNumberWidget> {
  late InputNumberModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputNumberModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.exactNumberTextController?.text =
            widget!.initialNumber.toString();
      });
    });

    _model.exactNumberTextController ??=
        TextEditingController(text: widget!.initialNumber.toString());
    _model.exactNumberFocusNode ??= FocusNode();
    _model.exactNumberFocusNode!.addListener(
      () async {
        if (_model.exactNumberTextController.text == '0') {
          safeSetState(() {
            _model.exactNumberTextController?.text = '1';
          });
        }
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    safeSetState(() {
                      _model.exactNumberTextController?.text = ((int number) {
                        return number == 0 ? 0 : number - 1;
                      }(int.parse(_model.exactNumberTextController.text)))
                          .toString();
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
                      FFIcons.kminus,
                      color: FlutterFlowTheme.of(context).tsTextDefault,
                      size: 16.0,
                    ),
                  ),
                ),
                Expanded(
                  child: FocusTraversalOrder(
                    order: const NumericFocusOrder(1000.0),
                    child: TextFormField(
                      controller: _model.exactNumberTextController,
                      focusNode: _model.exactNumberFocusNode,
                      autofocus: false,
                      enabled: true,
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
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).tsTextDefault,
                      validator: _model.exactNumberTextControllerValidator
                          .asValidator(context),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
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
                    safeSetState(() {
                      _model.exactNumberTextController?.text =
                          (int.parse(_model.exactNumberTextController.text) + 1)
                              .toString();
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
                      FFIcons.kplus,
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
