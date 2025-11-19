import 'dart:async';

import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/core_module.dart';
import 'package:starter/core/di/data_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/application/environment/configs/environment_module.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/auth/configs/auth_module.dart';
import 'package:starter/features/profile/configs/profile_module.dart';
import 'package:starter/features/settings/configs/settings_module.dart';
import 'package:starter/features/task/configs/task_module.dart';

class AppConfigurator {
  static final List<AppModule> _allModules = [
    CoreModule(),
    EnvironmentModule(),
    DataModule(),
    AuthModule(),
    SettingsModule(),
    ProfileModule(),
    TaskModule(),
  ];

  static Future<void> configure() async {
    for (final module in _allModules) {
      await module.registerDependencies();
    }
  }

  static Future<void> reconfigure(AppEnvironment newEnvironment) async {
    if (getIt.isRegistered<AppEnvironment>()) {
      await getIt.unregister<AppEnvironment>();
    }

    getIt.registerSingleton<AppEnvironment>(newEnvironment);

    final modulesToReregister = _allModules
        .where((module) => module.requiresReconfiguration)
        .toList();

    for (final module in modulesToReregister) {
      await module.registerDependencies();
    }
  }
}
