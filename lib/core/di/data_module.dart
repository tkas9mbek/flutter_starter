import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/core/data/dio_provider.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/global/instance_names.dart';
import 'package:starter/core/global/storage_keys.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/dio_api_client.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class DataModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  List<Unregister> get unregisterCallbacks => [
    unregisterIfRegistered<ApiClient>,
    () => unregisterIfRegistered<ApiClient>(instanceName: InstanceNames.unauthorized),
    () => unregisterIfRegistered<Dio>(
      disposingFunction: (dio) => dio.close(force: true),
    ),
    () => unregisterIfRegistered<Dio>(
      instanceName: InstanceNames.unauthorized,
      disposingFunction: (dio) => dio.close(force: true),
    ),
  ];

  @override
  void register() {
    final secureStorage = getIt<FlutterSecureStorage>();
    final authInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(
          key: SecureStorageKeys.jwtTokenKey,
        );

        if (token == null) {
          if (getIt.isRegistered<AuthRepository>()) {
            unawaited(getIt<AuthRepository>().logout());
          }

          return handler.reject(
            DioException(
              requestOptions: options,
              response: Response<dynamic>(
                requestOptions: options,
                statusCode: 401,
              ),
              type: DioExceptionType.badResponse,
              error: const UnauthorizedException(),
            ),
          );
        }

        options.headers['Authorization'] = 'Bearer $token';

        return handler.next(options);
      },
    );

    final dioProvider = DioProvider(
      authInterceptor: authInterceptor,
      logout: () async => getIt.get<AuthRepository>().logout(),
    );

    final env = getIt<AppEnvironment>();

    // Template guard: the placeholder consts in CoreConsts must be replaced
    // before any real backend is used. Debug-only by design — the mock
    // environment stays runnable out of the box.
    assert(
      env.useMock || !env.baseUrl.contains('example.com'),
      'CoreConsts.prodBaseUrl / devBaseUrl still contain the example.com '
      'placeholder. Replace them with your backend hosts before running '
      "the '${env.name}' environment.",
    );

    getIt
      ..registerSingleton<Dio>(
        dioProvider.getDio(useToken: false),
        instanceName: InstanceNames.unauthorized,
      )
      ..registerSingleton<Dio>(dioProvider.getDio(useToken: true))
      ..registerFactory<ApiClient>(
        () => DioApiClient(
          dio: getIt<Dio>(instanceName: InstanceNames.unauthorized),
          baseUrl: env.baseApiUrl,
        ),
        instanceName: InstanceNames.unauthorized,
      )
      ..registerFactory<ApiClient>(
        () => DioApiClient(dio: getIt<Dio>(), baseUrl: env.baseApiUrl),
      );
  }
}
