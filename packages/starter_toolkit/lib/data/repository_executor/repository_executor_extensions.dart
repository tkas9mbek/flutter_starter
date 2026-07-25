import 'package:starter_toolkit/data/repository_executor/error_handling_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/retry_executor.dart';

/// Extension methods for convenient executor chaining.
extension RepositoryExecutorExtensions on RepositoryExecutor {
  /// Wraps this executor so thrown errors are normalized to AppException types.
  // ignore: use_to_and_as_if_applicable
  RepositoryExecutor withErrorHandling() {
    return ErrorHandlingExecutor(this);
  }

  /// Wraps this executor to retry failed operations with a growing delay.
  RepositoryExecutor withRetry({
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) {
    return RetryExecutor(this, maxRetries: maxRetries, retryDelay: retryDelay);
  }
}
