import 'dart:async';
import 'dart:ui';

final class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}
