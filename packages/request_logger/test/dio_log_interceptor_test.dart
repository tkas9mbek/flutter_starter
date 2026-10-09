import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:request_logger/controller/request_logger.dart';
import 'package:request_logger/data/http_bean.dart';
import 'package:request_logger/data/http_log_manager.dart';
import 'package:request_logger/data/request_status.dart';
import 'package:starter_toolkit/data/interceptor/app_error_interceptor.dart';

import 'support/fake_adapter.dart';

void main() {
  final manager = HttpLogManager.instance;

  Dio buildDio(Future<ResponseBody> Function(RequestOptions) handler) {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
    dio.httpClientAdapter = FakeAdapter(handler);
    dio.interceptors.add(RequestLogger.dioInterceptor());

    return dio;
  }

  setUp(manager.cleanHTTP);

  test('captures a request and its response with timing', () async {
    final dio = buildDio((_) async => FakeAdapter.json({'name': 'John'}));

    await dio.get<dynamic>('/profile', queryParameters: {'page': 1});

    final log = manager.logValues().single;
    expect(log.request?.method, 'GET');
    expect(log.request?.url.path, '/profile');
    expect(log.request?.params, {'page': 1});
    expect(log.response?.statusCode, 200);
    expect(log.response?.data, {'name': 'John'});
    expect(log.response?.duration, isNotNull);
    expect(log.status, RequestStatus.success);
  });

  test(
    'redacts the auth header and token fields in request and response',
    () async {
      final dio = buildDio(
        (_) async => FakeAdapter.json({
          'accessToken': 'response-secret',
          'user': {'refreshToken': 'nested-secret', 'name': 'John'},
        }),
      );

      await dio.post<dynamic>(
        '/login',
        data: {'phone': '1234567890', 'authToken': 'request-secret'},
        options: Options(headers: {'Authorization': 'Bearer abc'}),
      );

      final log = manager.logValues().single;
      expect(log.request?.headers?['Authorization'], 'Hidden');
      expect(log.request?.body, {'phone': '1234567890', 'authToken': 'Hidden'});
      final responseData = log.response?.data as Map<String, dynamic>;
      expect(responseData['accessToken'], 'Hidden');
      expect((responseData['user'] as Map)['refreshToken'], 'Hidden');
      expect((responseData['user'] as Map)['name'], 'John');
    },
  );

  test('captures an HTTP error with its status code', () async {
    final dio = buildDio(
      (_) async => FakeAdapter.json({'message': 'boom'}, status: 500),
    );

    await expectLater(dio.get<dynamic>('/tasks'), throwsA(isA<DioException>()));

    final log = manager.logValues().single;
    expect(log.error?.statusCode, 500);
    expect(log.status, RequestStatus.error);
  });

  test('flags a socket failure as no-internet', () async {
    final dio = buildDio(
      (_) async => throw const SocketException(
        'Failed host lookup',
        osError: OSError('No address associated with hostname', 7),
      ),
    );

    await expectLater(dio.get<dynamic>('/tasks'), throwsA(isA<DioException>()));

    final log = manager.logValues().single;
    expect(log.status, RequestStatus.noInternet);
  });

  test('keeps only the 50 newest calls', () async {
    final dio = buildDio((_) async => FakeAdapter.json({'ok': true}));

    for (var i = 0; i < 53; i++) {
      await dio.get<dynamic>('/item/$i');
    }

    final paths = manager.logValues().map(
      (HttpBean log) => log.request?.url.path,
    );
    expect(paths.length, 50);
    expect(paths, isNot(contains('/item/0')));
    expect(paths, contains('/item/52'));
  });

  test('cleanHTTP empties the log', () async {
    final dio = buildDio((_) async => FakeAdapter.json({}));
    await dio.get<dynamic>('/a');
    expect(manager.logValues(), hasLength(1));

    manager.cleanHTTP();

    expect(manager.logValues(), isEmpty);
  });

  group('behind AppErrorInterceptor (the real app chain)', () {
    Dio buildAppDio(Future<ResponseBody> Function(RequestOptions) handler) {
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
      dio.httpClientAdapter = FakeAdapter(handler);
      dio.interceptors
        ..add(const AppErrorInterceptor())
        ..add(RequestLogger.dioInterceptor());

      return dio;
    }

    test('an HTTP error keeps its status, type and the server body', () async {
      final dio = buildAppDio(
        (_) async => FakeAdapter.json({'message': 'Not found'}, status: 404),
      );

      await expectLater(
        dio.get<dynamic>('/tasks/1'),
        throwsA(isA<DioException>()),
      );

      final error = manager.logValues().single.error;
      expect(error?.statusCode, 404);
      expect(error?.errorType, 'badResponse');
      expect(error?.errorData, {'message': 'Not found'});
      expect(error?.errorMessage, isNotNull);
    });

    test('a connection failure keeps a readable message and type', () async {
      final dio = buildAppDio(
        (options) async => throw DioException.connectionError(
          requestOptions: options,
          reason: 'Failed host lookup',
          error: const SocketException(
            'Failed host lookup',
            osError: OSError('No address associated with hostname', 7),
          ),
        ),
      );

      await expectLater(
        dio.get<dynamic>('/tasks'),
        throwsA(isA<DioException>()),
      );

      final log = manager.logValues().single;
      expect(log.error?.statusCode, isNull);
      expect(log.error?.errorType, 'connectionError');
      expect(log.error?.errorMessage, contains('Failed host lookup'));
      expect(log.error?.errorData.toString(), isNot(startsWith('Instance of')));
      expect(log.status, RequestStatus.noInternet);
    });
  });
}
