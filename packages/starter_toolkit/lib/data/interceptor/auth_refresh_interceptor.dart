import 'package:dio/dio.dart';

/// On a 401, refreshes the token once and replays the request; logs out if refresh fails or
/// the retry still returns 401. Queued so concurrent 401s share a single refresh.
class AuthRefreshInterceptor extends QueuedInterceptor {
  AuthRefreshInterceptor({
    required this.dio,
    this.tryRefreshToken,
    this.logout,
  });

  final Dio dio;
  final Future<void> Function()? tryRefreshToken;
  final Future<void> Function()? logout;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    if (tryRefreshToken == null) {
      await logout?.call();

      return handler.reject(err);
    }

    try {
      await tryRefreshToken!.call();
      final refreshedResponse = await dio.fetch(err.requestOptions);

      return handler.resolve(refreshedResponse);
    } on DioException catch (refreshError) {
      if (refreshError.response?.statusCode == 401) {
        await logout?.call();
      }

      return handler.reject(refreshError);
    } catch (error, stackTrace) {
      await logout?.call();

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.unknown,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
