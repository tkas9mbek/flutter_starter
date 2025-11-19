import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/auth/data/mock_auth_authorized_data_source.dart';
import 'package:starter/features/auth/data/mock_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/data/secure_auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

class AuthModule extends AppModule {
  @override
  void registerDependencies() {
    getIt
      ..registerLazySingleton<AuthAuthorizedDataSource>(
        () => MockAuthAuthorizedDataSource(),
      )
      ..registerLazySingleton<AuthUnauthorizedDataSource>(
        () => MockAuthUnauthorizedDataSource(),
      )
      ..registerLazySingleton<AuthLocalDataSource>(
        () => SecureAuthLocalDataSource(
          getIt<FlutterSecureStorage>(),
          getIt<SharedPreferences>(),
        ),
      )
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepository(
          getIt<RepositoryExecutor>(),
          getIt<AuthAuthorizedDataSource>(),
          getIt<AuthUnauthorizedDataSource>(),
          getIt<AuthLocalDataSource>(),
        ),
      );
  }
}
