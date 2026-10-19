import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Reports errors to a crash-monitoring backend. Kept as an interface so the shared repository
/// executor stays testable without touching Firebase, and so nothing below `main.dart` needs a
/// Firebase import.
abstract class CrashReporter {
  const CrashReporter();

  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
    bool fatal = false,
  });
}

class NoopCrashReporter extends CrashReporter {
  const NoopCrashReporter();

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {}
}

class FirebaseCrashReporter extends CrashReporter {
  const FirebaseCrashReporter();

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    return FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }
}

/// Set once during app bootstrap, right after Firebase initializes successfully. Defaults to a
/// no-op so code that can run before bootstrap (and every unit test) never touches Firebase.
CrashReporter crashReporter = const NoopCrashReporter();
