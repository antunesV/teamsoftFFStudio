import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'component_card_schedule_model.dart';
export 'component_card_schedule_model.dart';

class ComponentCardScheduleWidget extends StatefulWidget {
  const ComponentCardScheduleWidget({
    super.key,
    this.callBack,
    this.height,
    this.padding,
  });

  final Future Function()? callBack;
  final int? height;
  final int? padding;

  @override
  State<ComponentCardScheduleWidget> createState() =>
      _ComponentCardScheduleWidgetState();
}

class _ComponentCardScheduleWidgetState
    extends State<ComponentCardScheduleWidget> {
  late ComponentCardScheduleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComponentCardScheduleModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            0.0,
            valueOrDefault<double>(
              widget!.padding?.toDouble(),
              0.0,
            ),
            0.0,
            0.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await widget.callBack?.call();
          },
          child: Container(
            width: 220.0,
            height: widget!.height?.toDouble(),
            decoration: BoxDecoration(
              color: _model.mouseRegionHovered!
                  ? FlutterFlowTheme.of(context).tsNeutral100
                  : Color(0x00000000),
              border: Border.all(
                color: FlutterFlowTheme.of(context).tsNeutral100,
              ),
            ),
            child: Visibility(
              visible: _model.mouseRegionHovered ?? true,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FFIcons.kplusCircle,
                      color: FlutterFlowTheme.of(context).tsNeutral700,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
      }),
    );
  }
}
