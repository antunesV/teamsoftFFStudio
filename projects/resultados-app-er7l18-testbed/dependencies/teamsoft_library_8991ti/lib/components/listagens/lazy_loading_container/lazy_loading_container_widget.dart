import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lazy_loading_container_model.dart';
export 'lazy_loading_container_model.dart';

class LazyLoadingContainerWidget extends StatefulWidget {
  const LazyLoadingContainerWidget({
    super.key,
    double? borderRadius,
    double? height,
    double? width,
    this.variant,
  })  : this.borderRadius = borderRadius ?? 8.0,
        this.height = height ?? 40.0,
        this.width = width ?? 100.0;

  final double borderRadius;
  final double height;
  final double width;
  final Variant? variant;

  @override
  State<LazyLoadingContainerWidget> createState() =>
      _LazyLoadingContainerWidgetState();
}

class _LazyLoadingContainerWidgetState extends State<LazyLoadingContainerWidget>
    with TickerProviderStateMixin {
  late LazyLoadingContainerModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LazyLoadingContainerModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 900.0.ms,
            color: () {
              if (widget!.variant == Variant.neutral) {
                return FlutterFlowTheme.of(context).tsNeutral200;
              } else if (widget!.variant == Variant.dark) {
                return FlutterFlowTheme.of(context).tsNeutral850;
              } else {
                return FlutterFlowTheme.of(context).tsNeutral200;
              }
            }(),
            angle: 0.524,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
      child: Container(
        width: valueOrDefault<double>(
          widget!.width,
          100.0,
        ),
        height: valueOrDefault<double>(
          widget!.height,
          40.0,
        ),
        decoration: BoxDecoration(
          color: () {
            if (widget!.variant == Variant.neutral) {
              return FlutterFlowTheme.of(context).tsNeutral50;
            } else if (widget!.variant == Variant.dark) {
              return Color(0xFF505050);
            } else {
              return FlutterFlowTheme.of(context).tsNeutral50;
            }
          }(),
          borderRadius: BorderRadius.circular(valueOrDefault<double>(
            widget!.borderRadius,
            8.0,
          )),
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
    );
  }
}
