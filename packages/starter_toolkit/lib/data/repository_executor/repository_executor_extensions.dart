import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Extension methods for convenient executor chaining.
extension RepositoryExecutorExtensions on RepositoryExecutor {
  /// Wraps executor with error handling.
  ///
  /// Converts all exceptions to AppException types.
  RepositoryExecutor withErrorHandling() {
    return ErrorHandlingExecutor(this);
  }

  /// Wraps executor with retry logic.
  ///
  /// Automatically retries failed operations with exponential backoff.
  RepositoryExecutor withRetry({
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) {
    return RetryExecutor(
      this,
      maxRetries: maxRetries,
      retryDelay: retryDelay,
    );
  }

  /// Wraps executor with caching capability.
  ///
  /// Provides time-based caching through [cached] method.
  CachingExecutor withCaching({
    Duration defaultTtl = const Duration(minutes: 5),
  }) {
    return CachingExecutor(
      this,
      defaultTtl: defaultTtl,
    );
  }
}
