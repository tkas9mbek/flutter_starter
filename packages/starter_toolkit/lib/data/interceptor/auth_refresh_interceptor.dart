import 'package:dio/dio.dart';

class AuthRefreshInterceptor extends QueuedInterceptor {
  final Dio dio;
  final Future<void> Function()? tryRefreshToken;
  final Future<void> Function()? logout;

  AuthRefreshInterceptor({
    required this.dio,
    this.tryRefreshToken,
    this.logout,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        await tryRefreshToken?.call();
        final response = await dio.fetch(err.requestOptions);

        return handler.resolve(response);
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          return logout?.call();
        }

        return handler.reject(e);
      }
    }

    return handler.next(err);
  }
}
