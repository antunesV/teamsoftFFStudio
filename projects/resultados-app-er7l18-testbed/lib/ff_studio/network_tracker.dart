import 'timeline.dart';

class FFNetworkTracker {
  static Future<T> trace<T>({
    required String endpoint,
    required String method,
    required Future<T> Function() callBuilder,
  }) async {
    final start = DateTime.now();
    try {
      final res = await callBuilder();
      FFTimeline.record('api_call', {
        'endpoint': endpoint,
        'method': method,
        'status': 200,
        'duration': DateTime.now().difference(start).inMilliseconds,
      });
      return res;
    } catch (e) {
      FFTimeline.record('api_call', {
        'endpoint': endpoint,
        'method': method,
        'status': 500,
        'duration': DateTime.now().difference(start).inMilliseconds,
        'error': e.toString(),
      });
      rethrow;
    }
  }
}
