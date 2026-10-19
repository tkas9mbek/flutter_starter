import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/utils/debouncer.dart';

void main() {
  test(
    'notify fires the constructor callback once after a quiet period',
    () => fakeAsync((async) {
      var calls = 0;
      final debouncer = Debouncer(callback: () => calls++)..notify();

      async.elapse(const Duration(milliseconds: 200));
      debouncer.notify();
      async.elapse(const Duration(milliseconds: 299));
      expect(calls, 0);

      async.elapse(const Duration(milliseconds: 1));
      expect(calls, 1);
    }),
  );

  test(
    'notify without a callback does nothing',
    () => fakeAsync((async) {
      Debouncer().notify();

      expect(async.pendingTimers, isEmpty);
    }),
  );

  test(
    'call runs only the latest callback after a custom delay',
    () => fakeAsync((async) {
      final fired = <String>[];
      final debouncer = Debouncer(delay: const Duration(seconds: 1))
        ..call(() => fired.add('first'))
        ..call(() => fired.add('second'));

      async.elapse(const Duration(seconds: 1));
      expect(fired, ['second']);

      debouncer.notify();
      async.elapse(const Duration(seconds: 1));
      expect(fired, ['second', 'second'], reason: 'call replaces the callback');
    }),
  );

  test(
    'dispose cancels pending work',
    () => fakeAsync((async) {
      var calls = 0;
      Debouncer(callback: () => calls++)
        ..notify()
        ..dispose();

      async.elapse(const Duration(seconds: 1));

      expect(calls, 0);
    }),
  );
}
