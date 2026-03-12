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
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'circle_loading_model.dart';
export 'circle_loading_model.dart';

class CircleLoadingWidget extends StatefulWidget {
  const CircleLoadingWidget({
    super.key,
    required this.diameterCircle,
    Color? backgroundColor,
    Color? circleColor,
  })  : this.backgroundColor = backgroundColor ?? const Color(0xFFF9FF00),
        this.circleColor = circleColor ?? const Color(0xFF00FFF1);

  final int? diameterCircle;
  final Color backgroundColor;
  final Color circleColor;

  @override
  State<CircleLoadingWidget> createState() => _CircleLoadingWidgetState();
}

class _CircleLoadingWidgetState extends State<CircleLoadingWidget>
    with TickerProviderStateMixin {
  late CircleLoadingModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CircleLoadingModel());

    animationsMap.addAll({
      'progressBarOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 5.0,
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
    return CircularPercentIndicator(
      percent: 0.75,
      radius: widget!.diameterCircle!.toDouble(),
      lineWidth: 6.0,
      animation: true,
      animateFromLastPercent: true,
      progressColor: widget!.circleColor,
      backgroundColor: widget!.backgroundColor,
    ).animateOnPageLoad(animationsMap['progressBarOnPageLoadAnimation']!);
  }
}
