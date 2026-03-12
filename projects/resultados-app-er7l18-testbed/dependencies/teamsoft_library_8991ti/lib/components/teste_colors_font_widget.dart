import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'teste_colors_font_model.dart';
export 'teste_colors_font_model.dart';

class TesteColorsFontWidget extends StatefulWidget {
  const TesteColorsFontWidget({super.key});

  @override
  State<TesteColorsFontWidget> createState() => _TesteColorsFontWidgetState();
}

class _TesteColorsFontWidgetState extends State<TesteColorsFontWidget> {
  late TesteColorsFontModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TesteColorsFontModel());

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
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tsPrimaryDefault,
          ),
          child: Text(
            FFLocalizations.of(context).getText(
              'lmllaaqt' /* Hello World */,
            ),
            style: FlutterFlowTheme.of(context).tsFontNormalSm.override(
                  font: GoogleFonts.roboto(
                    fontWeight:
                        FlutterFlowTheme.of(context).tsFontNormalSm.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontNormalSm.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextDefault,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).tsFontNormalSm.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontNormalSm.fontStyle,
                ),
          ),
        ),
      ],
    );
  }
}
