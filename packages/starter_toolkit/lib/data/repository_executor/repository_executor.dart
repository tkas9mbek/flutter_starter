/// Base class for repository executors that handle common concerns.
///
/// Implementations can add cross-cutting features like error handling,
/// caching, retry logic, or logging.
abstract class RepositoryExecutor {
  const RepositoryExecutor();

  /// Executes a repository operation with executor-specific behavior.
  Future<T> execute<T>(Future<T> Function() function);
}
