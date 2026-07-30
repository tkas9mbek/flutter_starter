import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/global/instance_names.dart';
import 'package:starter/features/auth/data/api_auth_authorized_data_source.dart';
import 'package:starter/features/auth/data/api_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/data/mock_auth_authorized_data_source.dart';
import 'package:starter/features/auth/data/mock_auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/data/secure_auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/domain/auth_local_data_source.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class AuthModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    unregisterIfRegistered<LoginBloc>,
    unregisterIfRegistered<RegistrationBloc>,
    unregisterIfRegistered<OtpBloc>,
    () => unregisterIfRegistered<AuthRepository>(
      disposingFunction: (repository) => repository.dispose(),
    ),
    unregisterIfRegistered<AuthLocalDataSource>,
    unregisterIfRegistered<AuthUnauthorizedDataSource>,
    unregisterIfRegistered<AuthAuthorizedDataSource>,
  ];

  @override
  void register() {
    getIt
      ..registerLazySingleton<AuthAuthorizedDataSource>(() {
        if (useMock) {
          return const MockAuthAuthorizedDataSource();
        }

        return RemoteAuthAuthorizedDataSource(getIt<ApiClient>());
      })
      ..registerLazySingleton<AuthUnauthorizedDataSource>(() {
        if (useMock) {
          return const MockAuthUnauthorizedDataSource();
        }

        return RemoteAuthUnauthorizedDataSource(
          getIt<ApiClient>(instanceName: InstanceNames.unauthorized),
        );
      })
      ..registerLazySingleton<AuthLocalDataSource>(
        () => SecureAuthLocalDataSource(
          getIt<FlutterSecureStorage>(),
          getIt<SharedPreferences>(),
        ),
      )
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepository(
          const RawRepositoryExecutor().withErrorHandling(),
          getIt<AuthAuthorizedDataSource>(),
          getIt<AuthUnauthorizedDataSource>(),
          getIt<AuthLocalDataSource>(),
        ),
      )
      ..registerFactory(() => LoginBloc(getIt<AuthRepository>()))
      ..registerFactory(() => RegistrationBloc(getIt<AuthRepository>()))
      ..registerFactory(() => OtpBloc(getIt<AuthRepository>()));
  }
}
