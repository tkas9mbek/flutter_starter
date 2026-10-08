import 'dart:io';

import 'package:dio/dio.dart';
import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_log_manager.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';
import 'package:request_logger/interceptor/log_redactor.dart';

/// Dio interceptor that mirrors every request/response/error into
/// [HttpLogManager] for [RequestLogListScreen] to display.
final class DioLogInterceptor implements Interceptor {
  DioLogInterceptor({
    List<String> hiddenHeaders = const [],
    List<String> hiddenFields = const [],
  }) : _redactor = LogRedactor(
         hiddenHeaders: hiddenHeaders,
         hiddenFields: hiddenFields,
       );

  final LogRedactor _redactor;
  final _logManager = HttpLogManager.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logManager.onRequest(
      HttpRequestBean(
        id: options.hashCode,
        url: options.uri,
        method: options.method,
        contentType: options.contentType,
        headers: _redactor.headers({
          ...options.headers,
          'followRedirects': options.followRedirects,
        }),
        requestTime: DateTime.now(),
        connectTimeout: options.connectTimeout?.inMilliseconds,
        receiveTimeout: options.receiveTimeout?.inMilliseconds,
        params: _redactor.fields(options.queryParameters),
        body: _redactor.body(options.data),
      ),
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logManager.onResponse(_responseBean(response));
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorData = switch (err.error) {
      final Map<dynamic, dynamic> map => map,
      final SocketException socket => {
        'Error': socket.message,
        'OS Error': socket.osError?.message,
        'OS Error code': socket.osError?.errorCode,
        'No internet': _isNetworkError(socket),
      },
      _ => err.error,
    };

    _logManager.onError(
      HttpErrorBean(
        id: err.requestOptions.hashCode,
        errorMessage: err.message,
        errorData: _redactor.body(errorData),
        statusCode: err.response?.statusCode,
        statusMessage: err.response?.statusMessage,
        url: err.requestOptions.uri,
        errorTime: DateTime.now(),
        response: switch (err.response) {
          final response? => _responseBean(response),
          null => null,
        },
      ),
    );
    handler.next(err);
  }

  HttpResponseBean _responseBean(Response response) => HttpResponseBean(
    id: response.requestOptions.hashCode,
    responseTime: DateTime.now(),
    statusCode: response.statusCode,
    url: response.requestOptions.uri,
    method: response.requestOptions.method,
    statusMessage: response.statusMessage,
    data: _redactor.body(response.data),
    headers: _redactor.headers(response.headers.map),
  );
}

bool _isNetworkError(SocketException error) {
  final errorCode = error.osError?.errorCode ?? -1;

  return errorCode == 7 || errorCode == 8;
}
