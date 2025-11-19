import 'dart:async';

abstract class AppModule {
  const AppModule();

  bool get requiresReconfiguration => false;

  FutureOr<void> registerDependencies();
}
