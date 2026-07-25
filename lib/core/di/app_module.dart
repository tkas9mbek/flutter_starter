import 'dart:async';

import 'package:starter/core/global/global_variables.dart';

typedef Unregister = Future<void> Function();

abstract class AppModule {
  const AppModule();

  bool get requiresReconfiguration => false;

  /// Tear-offs of [unregisterIfRegistered] for every type this module
  /// registers, e.g. `unregisterIfRegistered<TaskRepository>`.
  List<Unregister> get unregisterCallbacks => const [];

  /// Template method: runs [unregisterCallbacks], then [register].
  Future<void> registerDependencies() async {
    for (final unregister in unregisterCallbacks) {
      await unregister();
    }

    await register();
  }

  FutureOr<void> register();

  Future<void> unregisterIfRegistered<T extends Object>({
    String? instanceName,
    FutureOr<void> Function(T instance)? disposingFunction,
  }) async {
    if (!getIt.isRegistered<T>(instanceName: instanceName)) {
      return;
    }

    await getIt.unregister<T>(
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }
}
