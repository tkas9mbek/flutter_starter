import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';
import 'package:starter_toolkit/data/repository_executor/retry_executor.dart';

import '../../support/future_outcome.dart';

/// Operation that throws [failures] in order, then returns `'ok'`.
class _FlakyOperation {
  _FlakyOperation(this.failures);

  final List<Object> failures;
  int calls = 0;

  Future<String> call() async {
    calls++;

    if (calls <= failures.length) {
      throw failures[calls - 1];
    }

    return 'ok';
  }
}

void main() {
  final executor = const RawRepositoryExecutor().withRetry();

  test(
    'returns the first success without waiting',
    () => fakeAsync((async) {
      final operation = _FlakyOperation(const []);
      final outcome = FutureOutcome(executor.execute(operation.call));

      async.flushMicrotasks();

      expect(outcome.value, 'ok');
      expect(operation.calls, 1);
      expect(async.pendingTimers, isEmpty);
    }),
  );

  test(
    'retries a retryable failure with a linear 2s, 4s backoff',
    () => fakeAsync((async) {
      final operation = _FlakyOperation(const [
        NoInternetException(),
        InternalServerErrorException(),
      ]);
      final outcome = FutureOutcome(executor.execute(operation.call));

      async.flushMicrotasks();
      expect(operation.calls, 1);

      async.elapse(const Duration(milliseconds: 1999));
      expect(operation.calls, 1);
      async.elapse(const Duration(milliseconds: 1));
      expect(operation.calls, 2);

      async.elapse(const Duration(milliseconds: 3999));
      expect(operation.calls, 2);
      async.elapse(const Duration(milliseconds: 1));
      expect(operation.calls, 3);

      expect(outcome.value, 'ok');
    }),
  );

  test(
    'gives up after 3 attempts total with the last exception',
    () => fakeAsync((async) {
      const last = ServerException(statusCode: 503, message: 'last');
      final operation = _FlakyOperation(const [
        ServerException(statusCode: 503, message: 'first'),
        ServerException(statusCode: 503, message: 'second'),
        last,
        ServerException(statusCode: 503, message: 'never reached'),
      ]);
      final outcome = FutureOutcome(executor.execute(operation.call));

      async.elapse(const Duration(seconds: 6));

      expect(operation.calls, 3);
      expect(outcome.error, same(last));
      expect(async.pendingTimers, isEmpty);
    }),
  );

  test(
    'does not retry an exception that cannot be retried',
    () => fakeAsync((async) {
      const exception = UnauthorizedException(message: 'Expired');
      final operation = _FlakyOperation(const [exception]);
      final outcome = FutureOutcome(executor.execute(operation.call));

      async.flushMicrotasks();

      expect(operation.calls, 1);
      expect(outcome.error, same(exception));
      expect(async.pendingTimers, isEmpty);
    }),
  );

  test(
    'does not retry an error that is not an AppException',
    () => fakeAsync((async) {
      final error = StateError('bug');
      final operation = _FlakyOperation([error]);
      final outcome = FutureOutcome(executor.execute(operation.call));

      async.flushMicrotasks();

      expect(operation.calls, 1);
      expect(outcome.error, same(error));
    }),
  );

  test(
    'honours a custom attempt count and base delay',
    () => fakeAsync((async) {
      final operation = _FlakyOperation(const [
        NoInternetException(),
        NoInternetException(),
      ]);
      final outcome = FutureOutcome(
        const RawRepositoryExecutor()
            .withRetry(maxAttempts: 2, retryDelay: const Duration(seconds: 1))
            .execute(operation.call),
      );

      async.elapse(const Duration(milliseconds: 999));
      expect(operation.calls, 1);
      async.elapse(const Duration(milliseconds: 1));

      expect(operation.calls, 2);
      expect(outcome.error, isA<NoInternetException>());
    }),
  );

  test(
    'a single attempt never waits',
    () => fakeAsync((async) {
      final operation = _FlakyOperation(const [NoInternetException()]);
      final outcome = FutureOutcome(
        const RawRepositoryExecutor()
            .withRetry(maxAttempts: 1)
            .execute(operation.call),
      );

      async.flushMicrotasks();

      expect(operation.calls, 1);
      expect(outcome.error, isA<NoInternetException>());
      expect(async.pendingTimers, isEmpty);
    }),
  );

  test(
    'rejects fewer than one attempt',
    () => expect(
      () => RetryExecutor(const RawRepositoryExecutor(), maxAttempts: 0),
      throwsAssertionError,
    ),
  );
}
