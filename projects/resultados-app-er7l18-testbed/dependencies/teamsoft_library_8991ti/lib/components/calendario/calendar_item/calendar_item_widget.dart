import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_item_model.dart';
export 'calendar_item_model.dart';

class CalendarItemWidget extends StatefulWidget {
  const CalendarItemWidget({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<CalendarItemWidget> createState() => _CalendarItemWidgetState();
}

class _CalendarItemWidgetState extends State<CalendarItemWidget> {
  late CalendarItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarItemModel());

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
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Icon(
                  FFIcons.khandbagSimple,
                  color: FlutterFlowTheme.of(context).tsTextDefault,
                  size: 16.0,
                ),
              ),
              Expanded(
                child: Text(
                  valueOrDefault<String>(
                    widget!.title,
                    'evento',
                  ),
                  style: FlutterFlowTheme.of(context).tsFontNormalSm.override(
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
                ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
        ),
      ],
    );
  }
}
