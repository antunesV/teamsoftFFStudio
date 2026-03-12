import 'package:flutter/material.dart';
import 'telemetry.dart';
import 'frame_monitor.dart';

class FFStudioRoot extends StatefulWidget {
  final Widget child;
  const FFStudioRoot({Key? key, required this.child}) : super(key: key);

  @override
  _FFStudioRootState createState() => _FFStudioRootState();
}

class _FFStudioRootState extends State<FFStudioRoot> {
  @override
  void initState() {
    super.initState();
    FFTelemetry().initialize(onRebuild: () {
      if (mounted) {
        setState(() {});
      }
    });
    FFFrameMonitor.start();
  }

  @override
  Widget build(BuildContext context) {
    // This wrapper allows capturing app-level telemetry and forcing rebuilds
    return widget.child;
  }
}
