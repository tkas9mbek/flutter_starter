import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';

class CoreModule extends AppModule {
  @override
  Future<void> registerDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();

    getIt
      ..registerSingleton<SharedPreferences>(prefs)
      ..registerSingleton<FlutterSecureStorage>(secureStorage);
  }
}
