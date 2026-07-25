import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

/// Innermost executor that runs the function directly; all decorators wrap this.
class RawRepositoryExecutor extends RepositoryExecutor {
  const RawRepositoryExecutor();

  @override
  Future<T> execute<T>(Future<T> Function() function) async {
    return function();
  }
}
