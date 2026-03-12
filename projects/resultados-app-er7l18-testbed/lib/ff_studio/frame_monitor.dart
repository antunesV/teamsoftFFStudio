import 'package:flutter/scheduler.dart';
import 'timeline.dart';

class FFFrameMonitor {
  static void start() {
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      for (var timing in timings) {
        if (timing.totalSpan.inMilliseconds > 20) {
          FFTimeline.record('frame_time', {
            'durationMs': timing.totalSpan.inMilliseconds,
            'buildDurationMs': timing.buildDuration.inMilliseconds,
            'rasterDurationMs': timing.rasterDuration.inMilliseconds,
          });
        }
      }
    });
  }
}
