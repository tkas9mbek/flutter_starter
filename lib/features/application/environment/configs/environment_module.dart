import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/application/environment/data/local_environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_data_source.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/main.dart';

class EnvironmentModule extends AppModule {
  @override
  void registerDependencies() {
    getIt
      ..registerLazySingleton<EnvironmentDataSource>(
        () => LocalEnvironmentDataSource(
          getIt<SharedPreferences>(),
          getIt<FlutterSecureStorage>(),
        ),
      )
      ..registerLazySingleton(
        () => EnvironmentRepository(
          getIt<EnvironmentDataSource>(),
          onEnvironmentChanged: reconfigureApplication,
        ),
      );

    final initialEnvironment = getIt<EnvironmentRepository>().getEnvironment();

    getIt.registerSingleton<AppEnvironment>(initialEnvironment);
  }
}
