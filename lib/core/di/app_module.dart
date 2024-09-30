import 'dart:async';

abstract class AppModule {
  const AppModule();

  FutureOr<void> registerDependencies();
}
