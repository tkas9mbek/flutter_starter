import 'dart:io';

import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

/// Dio interceptor that converts network errors to AppException types.
class AppErrorInterceptor extends Interceptor {
  /// Provide custom dioErrorHandler to override default behavior.
  final Function(DioException err)? customDioErrorHandler;

  const AppErrorInterceptor({
    this.customDioErrorHandler,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    customDioErrorHandler?.call(err);

    if (err.error is SocketException) {
      throw const NoInternetException();
    }

    final responseData = err.response?.data;
    final message = responseData is Map<String, dynamic>
        ? responseData['message'] as String?
        : null;

    throw ServerException(
      statusCode: err.response?.statusCode,
      message: message,
    );
  }
}
