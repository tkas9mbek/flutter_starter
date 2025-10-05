import 'dart:io';

import 'package:dio/dio.dart';
import 'package:starter_toolkit/data/exceptions/no_internet_exception.dart';
import 'package:starter_toolkit/data/exceptions/server_exception.dart';

class AppErrorInterceptor extends Interceptor {
  /// provide custom dioErrorHandler in order to override default behaviour
  final Function(DioException err)? customDioErrorHandler;

  AppErrorInterceptor({
    this.customDioErrorHandler,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    customDioErrorHandler?.call(err);

    if (err.error is SocketException) {
      throw NoInternetException();
    }

    throw ServerException.concrete(
      statusCode: err.response?.statusCode,
      response: err.response,
    );
  }
}
