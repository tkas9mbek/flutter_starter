import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/preferences/data/local_preferences_data_source.dart';
import 'package:starter/features/preferences/data/preferences_data_source.dart';
import 'package:starter/features/preferences/repository/preferences_repository.dart';

class PreferencesModule extends AppModule {
  @override
  void registerDependencies() {
    getIt
      ..registerLazySingleton<PreferencesDataSource>(
        () => LocalPreferencesDataSource(
          getIt<SharedPreferences>(),
        ),
      )
      ..registerLazySingleton(
        () => PreferencesRepository(
          getIt<PreferencesDataSource>(),
        ),
      );
  }
}
