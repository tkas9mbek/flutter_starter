abstract class RepositoryExecutor {
  Future<T> execute<T>(Future<T> Function() function);
}
