import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/crash/crash_reporter.dart';

void main() {
  test('crashReporter defaults to NoopCrashReporter', () {
    expect(crashReporter, isA<NoopCrashReporter>());
  });

  test('NoopCrashReporter.recordError completes without touching Firebase', () async {
    const reporter = NoopCrashReporter();

    await expectLater(
      reporter.recordError(Exception('boom'), StackTrace.current, fatal: true),
      completes,
    );
  });
}
