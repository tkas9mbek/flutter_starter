import 'dart:async';

import 'package:starter/core/di/injection.dart';

abstract class AppModule {
  const AppModule();

  bool get requiresReconfiguration => false;

  FutureOr<void> registerDependencies();

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
