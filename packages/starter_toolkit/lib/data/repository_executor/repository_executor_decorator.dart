import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Base decorator for wrapping repository executors.
///
/// Decorators add additional behavior while delegating to wrapped executor.
abstract class RepositoryExecutorDecorator extends RepositoryExecutor {
  /// The wrapped executor to delegate calls to
  final RepositoryExecutor wrapped;

  const RepositoryExecutorDecorator(this.wrapped);
}
