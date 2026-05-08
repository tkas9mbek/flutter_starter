import 'dart:io';

import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

/// Dio interceptor that converts network errors to AppException types.
class AppErrorInterceptor extends Interceptor {
  const AppErrorInterceptor({this.customDioErrorHandler});

  /// Provide custom dioErrorHandler to override default behavior.
  final Function(DioException err)? customDioErrorHandler;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    customDioErrorHandler?.call(err);

    if (err.error is AppException) {
      return handler.next(err);
    }

    final appException = err.error is SocketException
        ? const NoInternetException()
        : AppException.fromDioResponse(
            statusCode: err.response?.statusCode,
            response: err.response,
          );

    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        stackTrace: err.stackTrace,
        message: err.message,
      ),
    );
  }
}
