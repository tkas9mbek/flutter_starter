/// Runs repository operations, wrapped by decorators for cross-cutting concerns
/// like error handling and retry.
abstract class RepositoryExecutor {
  const RepositoryExecutor();

  /// Executes a repository operation with executor-specific behavior.
  Future<T> execute<T>(Future<T> Function() function);
}
