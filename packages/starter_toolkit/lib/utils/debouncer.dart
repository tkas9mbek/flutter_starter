// ignore_for_file: prefer_initializing_formals

import 'dart:async';

/// Delays callback execution until [delay] has passed without a new trigger.
///
/// Either construct with a fixed [callback] and trigger via [notify], or pass
/// the callback per call site via [call]. Call [dispose] to cancel pending
/// work.
class Debouncer {
  Debouncer({
    this.delay = const Duration(milliseconds: 300),
    void Function()? callback,
  }) : _callback = callback;

  final Duration delay;

  void Function()? _callback;
  Timer? _timer;

  /// Restarts the timer for the constructor-provided callback.
  void notify() {
    final callback = _callback;
    if (callback == null) {
      return;
    }

    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  /// Restarts the timer with [callback], replacing any previous one.
  void call(void Function() callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
