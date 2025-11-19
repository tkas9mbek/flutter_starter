import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/core_module.dart';
import 'package:starter/core/di/data_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/application/application.dart';
import 'package:starter/features/application/environment/configs/environment_module.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/auth/configs/auth_module.dart';
import 'package:starter/features/profile/configs/profile_module.dart';
import 'package:starter/features/settings/configs/settings_module.dart';
import 'package:starter/features/task/configs/task_module.dart';

Future<void> configureApplication() async {
  final modules = <AppModule>[
    CoreModule(),
    DataModule(),
    EnvironmentModule(),
    AuthModule(),
    SettingsModule(),
    ProfileModule(),
    TaskModule(),
  ];

  for (final module in modules) {
    await module.registerDependencies();
  }
}

Future<void> reconfigureApplication(AppEnvironment newEnvironment) async {
  if (getIt.isRegistered<AppEnvironment>()) {
    await getIt.unregister<AppEnvironment>();
  }

  getIt.registerSingleton<AppEnvironment>(newEnvironment);

  final modulesToReregister = <AppModule>[
    DataModule(),
    AuthModule(),
    ProfileModule(),
    TaskModule(),
  ];

  for (final module in modulesToReregister) {
    await module.registerDependencies();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureApplication();

  Bloc.transformer = sequential();

  runApp(const Application());
}
