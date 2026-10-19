import 'package:flutter_test/flutter_test.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/http_error_bean.dart';
import 'package:request_logger/data/http_request_bean.dart';
import 'package:request_logger/data/http_response_bean.dart';
import 'package:request_logger/data/request_status.dart';

void main() {
  final url = Uri.parse('https://api.test/tasks');
  final time = DateTime(2026);

  HttpBean bean({HttpResponseBean? response, HttpErrorBean? error}) => HttpBean(
    request: HttpRequestBean(id: 1, url: url, requestTime: time, method: 'GET'),
    response: response,
    error: error,
  );

  HttpErrorBean error({
    int? statusCode,
    String? errorMessage,
    String? errorType,
    dynamic errorData,
  }) => HttpErrorBean(
    id: 1,
    url: url,
    errorTime: time,
    statusCode: statusCode,
    errorMessage: errorMessage,
    errorType: errorType,
    errorData: errorData,
  );

  final cases = <String, (HttpBean, RequestStatus)>{
    'no answer yet is sending': (bean(), RequestStatus.sending),
    'a response with a status is success': (
      bean(
        response: HttpResponseBean(
          id: 1,
          url: url,
          responseTime: time,
          statusCode: 200,
        ),
      ),
      RequestStatus.success,
    ),
    'a response without a status is error': (
      bean(
        response: HttpResponseBean(id: 1, url: url, responseTime: time),
      ),
      RequestStatus.error,
    ),
    'an HTTP error is error': (
      bean(error: error(statusCode: 500, errorType: 'connectionError')),
      RequestStatus.error,
    ),
    'a connect timeout message is no-internet': (
      bean(error: error(errorMessage: 'Connecting timed out [30000ms]')),
      RequestStatus.noInternet,
    ),
    'an OS error code 101 is no-internet': (
      bean(error: error(errorData: <String, dynamic>{'OS Error code': 101})),
      RequestStatus.noInternet,
    ),
    'another OS error code is error': (
      bean(error: error(errorData: <String, dynamic>{'OS Error code': 1})),
      RequestStatus.error,
    ),
    'a connectionTimeout type is no-internet': (
      bean(error: error(errorType: 'connectionTimeout')),
      RequestStatus.noInternet,
    ),
    'an unknown error type is error': (
      bean(error: error(errorType: 'unknown')),
      RequestStatus.error,
    ),
  };

  cases.forEach((name, testCase) {
    final (log, expected) = testCase;

    test('status: $name', () => expect(log.status, expected));
  });
}
