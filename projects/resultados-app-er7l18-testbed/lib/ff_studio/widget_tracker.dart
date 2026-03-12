import 'package:flutter/material.dart';
import 'timeline.dart';

class FFWidgetTracker extends StatefulWidget {
  final Widget child;
  final String name;

  const FFWidgetTracker({Key? key, required this.child, required this.name}) : super(key: key);

  @override
  _FFWidgetTrackerState createState() => _FFWidgetTrackerState();
}

class _FFWidgetTrackerState extends State<FFWidgetTracker> {
  @override
  Widget build(BuildContext context) {
    final sw = Stopwatch()..start();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sw.stop();
      FFTimeline.record('widget_rebuild', {
        'widget': widget.name,
        'buildDuration': sw.elapsedMilliseconds,
      });
    });
    return widget.child;
  }
}
