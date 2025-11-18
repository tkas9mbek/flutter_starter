export 'caching_executor.dart';
export 'error_handling_executor.dart';
export 'raw_repository_executor.dart';
export 'repository_executor_decorator.dart';
export 'repository_executor_extensions.dart';
export 'retry_executor.dart';

/// Base class for repository executors that handle common concerns.
///
/// Implementations can add cross-cutting features like error handling,
/// caching, retry logic, or logging.
abstract class RepositoryExecutor {
  const RepositoryExecutor();

  /// Executes a repository operation with executor-specific behavior.
  Future<T> execute<T>(Future<T> Function() function);
}
