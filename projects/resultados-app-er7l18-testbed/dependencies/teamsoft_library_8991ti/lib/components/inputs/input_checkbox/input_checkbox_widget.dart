import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'input_checkbox_model.dart';
export 'input_checkbox_model.dart';

class InputCheckboxWidget extends StatefulWidget {
  const InputCheckboxWidget({
    super.key,
    this.toggle,
    this.variant,
  });

  /// 0 - vazio
  /// 1 - tracinho
  /// other or null - check
  final int? toggle;

  final Variant? variant;

  @override
  State<InputCheckboxWidget> createState() => _InputCheckboxWidgetState();
}

class _InputCheckboxWidgetState extends State<InputCheckboxWidget> {
  late InputCheckboxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputCheckboxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(
          builder: (context) {
            if ((widget!.toggle == 0) && (widget!.toggle != null)) {
              return Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  color: widget!.variant == Variant.dark
                      ? FlutterFlowTheme.of(context).tsTextDefault
                      : FlutterFlowTheme.of(context).tsNeutral0,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                  ),
                ),
              );
            } else if ((widget!.toggle == 1) && (widget!.toggle != null)) {
              return Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsTextDefault
                          : FlutterFlowTheme.of(context).tsTextInverter,
                      size: 14.0,
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FFIcons.kminus,
                      color: widget!.variant == Variant.dark
                          ? FlutterFlowTheme.of(context).tsTextDefault
                          : FlutterFlowTheme.of(context).tsTextInverter,
                      size: 14.0,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
