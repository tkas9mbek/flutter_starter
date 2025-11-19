import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Raw executor that directly executes functions without any decoration.
///
/// This is the base implementation that other decorators wrap.
class RawRepositoryExecutor extends RepositoryExecutor {
  const RawRepositoryExecutor();

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    return function();
  }
}
