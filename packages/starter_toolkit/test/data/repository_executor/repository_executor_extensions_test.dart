import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/error_handling_executor.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';
import 'package:starter_toolkit/data/repository_executor/retry_executor.dart';

import '../../support/future_outcome.dart';

DioException _rawStatus(int statusCode) {
  final requestOptions = RequestOptions(path: '/profile');

  return DioException.badResponse(
    statusCode: statusCode,
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
    ),
  );
}

void main() {
  test('extensions wrap the receiver in the matching decorator', () {
    const raw = RawRepositoryExecutor();
    final errorHandling = raw.withErrorHandling();
    final retry = errorHandling.withRetry(
      maxAttempts: 5,
      retryDelay: const Duration(seconds: 1),
    );

    expect(
      errorHandling,
      isA<ErrorHandlingExecutor>().having((e) => e.wrapped, 'wrapped', raw),
    );
    expect(
      retry,
      isA<RetryExecutor>()
          .having((e) => e.wrapped, 'wrapped', same(errorHandling))
          .having((e) => e.maxAttempts, 'maxAttempts', 5)
          .having(
            (e) => e.retryDelay,
            'retryDelay',
            const Duration(seconds: 1),
          ),
    );
  });

  test(
    'withRetry defaults to 3 attempts with a 2s base delay',
    () => expect(
      const RawRepositoryExecutor().withRetry(),
      isA<RetryExecutor>()
          .having((e) => e.maxAttempts, 'maxAttempts', 3)
          .having(
            (e) => e.retryDelay,
            'retryDelay',
            const Duration(seconds: 2),
          ),
    ),
  );

  group('withErrorHandling().withRetry()', () {
    final executor = const RawRepositoryExecutor()
        .withErrorHandling()
        .withRetry();

    test(
      'retries a raw 500 once it is mapped to a retryable exception',
      () => fakeAsync((async) {
        var calls = 0;
        final outcome = FutureOutcome(
          executor.execute<String>(() async {
            calls++;
            if (calls < 3) {
              throw _rawStatus(500);
            }

            return 'profile';
          }),
        );

        async.elapse(const Duration(seconds: 6));

        expect(calls, 3);
        expect(outcome.value, 'profile');
      }),
    );

    test(
      'fails fast on a raw 401 mapped to UnauthorizedException',
      () => fakeAsync((async) {
        var calls = 0;
        final outcome = FutureOutcome(
          executor.execute<void>(() async {
            calls++;
            throw _rawStatus(401);
          }),
        );

        async.flushMicrotasks();

        expect(calls, 1);
        expect(outcome.error, isA<UnauthorizedException>());
        expect(async.pendingTimers, isEmpty);
      }),
    );
  });

  // Retry only understands AppException, so error handling must sit
  // innermost; in the reverse order a raw 500 is mapped but never retried.
  test(
    'withRetry().withErrorHandling() cannot retry a raw DioException',
    () => fakeAsync((async) {
      var calls = 0;
      final outcome = FutureOutcome(
        const RawRepositoryExecutor()
            .withRetry()
            .withErrorHandling()
            .execute<void>(() async {
              calls++;
              throw _rawStatus(500);
            }),
      );

      async.elapse(const Duration(seconds: 6));

      expect(calls, 1);
      expect(outcome.error, isA<InternalServerErrorException>());
    }),
  );
}
