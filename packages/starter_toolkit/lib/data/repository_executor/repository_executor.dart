abstract class RepositoryExecutor {
  const RepositoryExecutor();

  Future<T> execute<T>(Future<T> Function() function);
}
