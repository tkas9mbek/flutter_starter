import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Base decorator that adds behavior while delegating to the [wrapped] executor.
abstract class RepositoryExecutorDecorator extends RepositoryExecutor {
  const RepositoryExecutorDecorator(this.wrapped);

  final RepositoryExecutor wrapped;
}
