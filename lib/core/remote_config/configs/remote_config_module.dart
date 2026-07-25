import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/firebase_config.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/remote_config/data/firebase_remote_config_data_source.dart';
import 'package:starter/core/remote_config/data/mock_remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/domain/remote_config_repository.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter/core/remote_config/model/remote_general_settings.dart';
import 'package:starter/core/remote_config/model/remote_phone_codes.dart';
import 'package:starter/core/remote_config/ui/bloc/remote_configs_bloc.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class RemoteConfigModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    unregisterIfRegistered<RemoteConfigsBloc<RemoteGeneralSettings>>,
    unregisterIfRegistered<RemoteConfigsBloc<RemotePhoneCodes>>,
    unregisterIfRegistered<RemoteConfigRepository>,
    unregisterIfRegistered<RemoteConfigDataSource>,
    unregisterIfRegistered<RemoteConfigRegistry>,
  ];

  @override
  Future<void> register() async {
    final generalDefault = await _loadDefault(
      'assets/remote_config/general.json',
      RemoteGeneralSettings.fromJson,
    );
    final phoneCodesDefault = await _loadDefault(
      'assets/remote_config/phone_code.json',
      RemotePhoneCodes.fromJson,
    );

    getIt
      ..registerLazySingleton<RemoteConfigRegistry>(
        () => RemoteConfigRegistry([
          RemoteConfigDescriptor<RemoteGeneralSettings>(
            key: 'general',
            fromJson: RemoteGeneralSettings.fromJson,
            defaultValue: generalDefault,
          ),
          RemoteConfigDescriptor<RemotePhoneCodes>(
            key: 'phone_code',
            fromJson: RemotePhoneCodes.fromJson,
            defaultValue: phoneCodesDefault,
          ),
        ]),
      )
      ..registerLazySingleton<RemoteConfigDataSource>(() {
        // Firebase path is an example — see FirebaseConfig.
        if (useMock || !FirebaseConfig.enabled) {
          return MockRemoteConfigDataSource(getIt<RemoteConfigRegistry>());
        }

        return FirebaseRemoteConfigDataSource(
          FirebaseRemoteConfig.instance,
          getIt<RemoteConfigRegistry>(),
        );
      })
      ..registerLazySingleton<RemoteConfigRepository>(
        () => RemoteConfigRepository(
          const RawRepositoryExecutor().withErrorHandling().withRetry(
            maxRetries: 3,
            retryDelay: const Duration(seconds: 2),
          ),
          getIt<RemoteConfigDataSource>(),
        ),
      )
      ..registerFactory<RemoteConfigsBloc<RemoteGeneralSettings>>(
        () => RemoteConfigsBloc<RemoteGeneralSettings>(
          getIt<RemoteConfigRepository>(),
        ),
      )
      ..registerFactory<RemoteConfigsBloc<RemotePhoneCodes>>(
        () => RemoteConfigsBloc<RemotePhoneCodes>(
          getIt<RemoteConfigRepository>(),
        ),
      );
  }

  Future<T> _loadDefault<T extends RemoteConfigEntry>(
    String assetPath,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw);
    // List-valued defaults (e.g. phone_code) are wrapped the same way
    // FirebaseRemoteConfigDataSource wraps list parameters.
    final json = decoded is List
        ? <String, dynamic>{'items': decoded}
        : decoded as Map<String, dynamic>;

    return fromJson(json);
  }
}
