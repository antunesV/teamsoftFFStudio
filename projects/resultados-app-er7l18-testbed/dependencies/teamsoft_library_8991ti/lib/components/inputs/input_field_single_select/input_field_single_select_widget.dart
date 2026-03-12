import '/backend/schema/enums/enums.dart';
import '/components/inputs/input_single_select/input_single_select_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_field_single_select_model.dart';
export 'input_field_single_select_model.dart';

class InputFieldSingleSelectWidget extends StatefulWidget {
  const InputFieldSingleSelectWidget({super.key});

  @override
  State<InputFieldSingleSelectWidget> createState() =>
      _InputFieldSingleSelectWidgetState();
}

class _InputFieldSingleSelectWidgetState
    extends State<InputFieldSingleSelectWidget> {
  late InputFieldSingleSelectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputFieldSingleSelectModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 200.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tsNeutral0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tsNeutral0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(0.0),
                    ),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tsNeutral300,
                      width: 1.0,
                    ),
                  ),
                  child: Container(
                    width: 100.0,
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: FFLocalizations.of(context).getText(
                          'bq0pez5s' /* TextField */,
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
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
                              color: FlutterFlowTheme.of(context).tsNeutral700,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontWeight,
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
                      cursorColor: FlutterFlowTheme.of(context).tsNeutral1000,
                      enableInteractiveSelection: true,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tsNeutral0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(8.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tsNeutral300,
                    ),
                  ),
                  child: wrapWithModel(
                    model: _model.inputSingleSelectModel,
                    updateCallback: () => safeSetState(() {}),
                    child: InputSingleSelectWidget(
                      label: 'tipo',
                      styleOnSelected: false,
                      hasError: false,
                      hasSearch: false,
                      unlink: false,
                      addable: false,
                      isBottomSheet: false,
                      variant: Variant.primary,
                      list: functions.randomJsonList(),
                      noBorder: true,
                      executeAction: (dataSingleSelect) async {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
