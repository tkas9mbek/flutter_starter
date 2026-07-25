import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Retries failed operations up to [maxRetries] times with a growing delay,
/// but only while the thrown [AppException] reports `canRetry`.
class RetryExecutor extends RepositoryExecutorDecorator {
  const RetryExecutor(
    super.wrapped, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  final int maxRetries;
  final Duration retryDelay;

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    for (var attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return await wrapped.execute(function);
      } on AppException catch (e) {
        if (!e.canRetry || attempt == maxRetries - 1) {
          rethrow;
        }

        // Linear backoff: delay grows with each attempt.
        await Future.delayed(retryDelay * (attempt + 1));
      }
    }

    // Unreachable: the loop always returns or rethrows on the final attempt.
    throw const DevelopmentException();
  }
}
