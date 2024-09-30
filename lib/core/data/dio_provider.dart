import 'package:dio/dio.dart';
import 'package:flutter_starter/core/consts.dart';
import 'package:flutter_starter/core/data/interceptor/app_error_interceptor.dart';
import 'package:flutter_starter/core/data/interceptor/auth_refresh_interceptor.dart';

class ApiProvider {
  final Interceptor? authInterceptor;
  final Future<void> Function()? tryRefreshToken;
  final Future<void> Function()? logout;

  ApiProvider({
    this.authInterceptor,
    this.tryRefreshToken,
    this.logout,
  });

  Dio getDio({
    bool useToken = true,
    Function(DioException)? customDioErrorHandler,
    String? baseUrl,
  }) {
    final baseOptions = BaseOptions(
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      connectTimeout:
          const Duration(seconds: Consts.apiTimeoutSeconds),
      receiveTimeout:
          const Duration(seconds: Consts.apiTimeoutSeconds),
    );
    final dio = Dio(baseOptions);
    final dioWithoutAuthInterceptor = Dio(baseOptions);

    if (useToken && authInterceptor != null) {
      dio.interceptors.add(authInterceptor!);
      dioWithoutAuthInterceptor.interceptors.add(authInterceptor!);
    }

    if (useToken && tryRefreshToken != null) {
      dio.interceptors.add(
        AuthRefreshInterceptor(
          dio: dioWithoutAuthInterceptor,
          tryRefreshToken: tryRefreshToken,
          logout: logout,
        ),
      );
    }

    dio.interceptors.add(
      AppErrorInterceptor(
        customDioErrorHandler: (exception) {
          customDioErrorHandler?.call(exception);
        },
      ),
    );

    return dio;
  }
}
