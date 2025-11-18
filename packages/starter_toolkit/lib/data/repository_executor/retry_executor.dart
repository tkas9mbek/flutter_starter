import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_decorator.dart';

/// Decorator adding retry logic with exponential backoff.
///
/// Automatically retries failed operations up to [maxRetries] times,
/// but only if the exception's canRetry is true.
class RetryExecutor extends RepositoryExecutorDecorator {
  final int maxRetries;
  final Duration retryDelay;

  const RetryExecutor(
    super.wrapped, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    for (var attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return await wrapped.execute(function);
      } on AppException catch (e) {
        // Check if retryable using pattern matching
        final canRetry = e.maybeWhen(
          unauthorized: (_) => false,
          forbidden: (_) => false,
          development: () => false,
          urlLaunchFailed: () => false,
          orElse: () => true,
        );

        if (!canRetry || attempt == maxRetries - 1) {
          rethrow;
        }

        // Wait before retry with exponential backoff
        await Future.delayed(retryDelay * (attempt + 1));
      }
    }

    // Should never reach here
    throw const AppException.development();
  }
}
