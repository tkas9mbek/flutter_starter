import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/interceptor/app_error_interceptor.dart';

import '../../support/fake_http_client_adapter.dart';

/// Sends one GET through a Dio with [AppErrorInterceptor] and returns the
/// [DioException] the caller receives.
Future<DioException> _failingRequest(
  FakeResponder respond, {
  void Function(DioException err)? onError,
}) async {
  final dio = fakeDio(
    FakeHttpClientAdapter(respond),
    interceptors: [AppErrorInterceptor(customDioErrorHandler: onError)],
  );

  try {
    await dio.get<Object?>('https://api.test/tasks');
  } on DioException catch (e) {
    return e;
  }

  throw StateError('request was expected to fail');
}

void main() {
  test(
    'maps an error status to its AppException and keeps the response',
    () async {
      final err = await _failingRequest(
        (_) async => jsonBody({'message': 'Expired'}, statusCode: 401),
      );

      expect(
        err.error,
        isA<UnauthorizedException>().having(
          (e) => e.message,
          'message',
          'Expired',
        ),
      );
      expect(err.type, DioExceptionType.badResponse);
      expect(err.response?.statusCode, 401);
    },
  );

  test('maps each status code to the matching subtype', () async {
    final cases = <int, Matcher>{
      403: isA<ForbiddenException>(),
      500: isA<InternalServerErrorException>(),
      404: isA<ServerException>().having(
        (e) => e.statusCode,
        'statusCode',
        404,
      ),
    };

    for (final MapEntry(key: statusCode, value: matcher) in cases.entries) {
      final err = await _failingRequest(
        (_) async => jsonBody(const {}, statusCode: statusCode),
      );

      expect(err.error, matcher, reason: 'status $statusCode');
    }
  });

  test(
    'maps a SocketException to NoInternetException, keeping its text',
    () async {
      final err = await _failingRequest(
        (_) async => throw const SocketException('Failed host lookup'),
      );

      expect(err.error, isA<NoInternetException>());
      expect(err.message, contains('Failed host lookup'));
    },
  );

  test(
    'maps a timeout to ServerException and keeps type and message',
    () async {
      final err = await _failingRequest(
        (options) async => throw DioException.connectionTimeout(
          timeout: const Duration(seconds: 30),
          requestOptions: options,
        ),
      );

      expect(
        err.error,
        isA<ServerException>().having(
          (e) => e.statusCode,
          'statusCode',
          isNull,
        ),
      );
      expect(err.type, DioExceptionType.connectionTimeout);
      expect(err.message, contains('30'));
    },
  );

  test('passes an error that is already an AppException through', () async {
    const exception = ForbiddenException(message: 'Blocked');

    final err = await _failingRequest(
      (options) async =>
          throw DioException(requestOptions: options, error: exception),
    );

    expect(err.error, same(exception));
  });

  test('reports the original error to the custom handler', () async {
    final reported = <DioException>[];

    await _failingRequest(
      (_) async => throw const SocketException('offline'),
      onError: reported.add,
    );

    expect(reported, hasLength(1));
    expect(reported.single.error, isA<SocketException>());
  });
}
