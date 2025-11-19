import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/core/consts/storage_keys.dart';
import 'package:starter/core/data/dio_provider.dart';
import 'package:starter/core/di/app_module.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/dio_api_client.dart';

class DataModule extends AppModule {
  @override
  bool get requiresReconfiguration => true;

  @override
  void registerDependencies() {
    final authInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await const FlutterSecureStorage().read(
          key: SecureStorageKeys.jwtTokenKey,
        );

        if (token == null) {
          return getIt.get<AuthRepository>().logout();
        }

        final headers = <String, dynamic>{
          'Authorization': 'Bearer $token',
        };

        options.headers.addAll(headers);
        handler.next(options);
      },
    );

    final apiProvider = ApiProvider(
      authInterceptor: authInterceptor,
      logout: () async => getIt.get<AuthRepository>().logout(),
    );

    final env = getIt<AppEnvironment>();

    getIt
      ..registerSingleton<Dio>(
        apiProvider.getDio(useToken: false),
        instanceName: 'unauthorized',
      )
      ..registerSingleton<Dio>(
        apiProvider.getDio(useToken: true),
      )
      ..registerFactory<ApiClient>(
        () => DioApiClient(
          dio: getIt<Dio>(instanceName: 'unauthorized'),
          baseUrl: env.baseApiUrl,
        ),
        instanceName: 'unauthorized',
      )
      ..registerFactory<ApiClient>(
        () => DioApiClient(
          dio: getIt<Dio>(),
          baseUrl: env.baseApiUrl,
        ),
      );
  }
}
