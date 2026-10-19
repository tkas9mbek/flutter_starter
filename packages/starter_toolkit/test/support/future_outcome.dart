import 'dart:async';

/// Records how a future settles, so a `fakeAsync` body can start it, advance
/// the fake clock, and then inspect the result synchronously.
class FutureOutcome<T> {
  FutureOutcome(Future<T> future) {
    unawaited(
      future.then(
        (value) {
          _value = value;
          _isCompleted = true;
        },
        onError: (Object error) {
          _error = error;
          _isCompleted = true;
        },
      ),
    );
  }

  T? _value;
  Object? _error;
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  T? get value => _value;

  Object? get error => _error;
}
