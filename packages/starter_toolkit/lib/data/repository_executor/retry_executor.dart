import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Calls the operation up to [maxAttempts] times in total (the first call plus
/// the retries), with a growing delay between calls, but only while the thrown
/// [AppException] reports `canRetry`.
class RetryExecutor extends RepositoryExecutorDecorator {
  const RetryExecutor(
    super.wrapped, {
    this.maxAttempts = 3,
    this.retryDelay = const Duration(seconds: 2),
  }) : assert(maxAttempts >= 1, 'maxAttempts must be at least 1');

  /// Must be at least 1.
  final int maxAttempts;
  final Duration retryDelay;

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await wrapped.execute(function);
      } on AppException catch (e) {
        if (!e.canRetry || attempt == maxAttempts - 1) {
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
