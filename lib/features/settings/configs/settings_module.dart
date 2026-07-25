import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/settings/data/local_settings_data_source.dart';
import 'package:starter/features/settings/data/settings_data_source.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';

class SettingsModule extends AppModule {
  @override
  void register() {
    getIt
      ..registerLazySingleton<SettingsDataSource>(
        () => LocalSettingsDataSource(getIt<SharedPreferences>()),
      )
      ..registerLazySingleton(
        () => SettingsRepository(getIt<SettingsDataSource>()),
      );
  }
}
