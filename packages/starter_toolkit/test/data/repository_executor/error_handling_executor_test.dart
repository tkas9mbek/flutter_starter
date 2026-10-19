import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

DioException _badResponse(int statusCode, {Object? data}) {
  final requestOptions = RequestOptions(path: '/tasks');

  return DioException.badResponse(
    statusCode: statusCode,
    requestOptions: requestOptions,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  final executor = const RawRepositoryExecutor().withErrorHandling();

  test(
    'raw executor returns the operation result unchanged',
    () async =>
        expect(await const RawRepositoryExecutor().execute(() async => 42), 42),
  );

  test(
    'passes a successful result through',
    () async => expect(await executor.execute(() async => 'tasks'), 'tasks'),
  );

  test('rethrows an AppException as the same instance', () async {
    const exception = ServerException(statusCode: 404, message: 'Not found');

    await expectLater(
      executor.execute<void>(() async => throw exception),
      throwsA(same(exception)),
    );
  });

  test('unwraps the AppException an interceptor put into a DioException', () {
    const exception = NoInternetException();

    expect(
      executor.execute<void>(
        () async => throw DioException(
          requestOptions: RequestOptions(path: '/tasks'),
          error: exception,
        ),
      ),
      throwsA(same(exception)),
    );
  });

  group('maps a raw DioException by status code', () {
    test(
      '401 to UnauthorizedException with the backend message',
      () => expect(
        executor.execute<void>(
          () async => throw _badResponse(401, data: {'message': 'Expired'}),
        ),
        throwsA(
          isA<UnauthorizedException>().having(
            (e) => e.message,
            'message',
            'Expired',
          ),
        ),
      ),
    );

    test(
      '403 to ForbiddenException',
      () => expect(
        executor.execute<void>(
          () async => throw _badResponse(403, data: {'message': 'No access'}),
        ),
        throwsA(
          isA<ForbiddenException>().having(
            (e) => e.message,
            'message',
            'No access',
          ),
        ),
      ),
    );

    test(
      '500 to InternalServerErrorException',
      () => expect(
        executor.execute<void>(() async => throw _badResponse(500)),
        throwsA(
          isA<InternalServerErrorException>().having(
            (e) => e.message,
            'message',
            isNull,
          ),
        ),
      ),
    );

    test(
      'any other status to ServerException with code and message',
      () => expect(
        executor.execute<void>(
          () async => throw _badResponse(404, data: {'message': 'Not found'}),
        ),
        throwsA(
          isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 404)
              .having((e) => e.message, 'message', 'Not found'),
        ),
      ),
    );

    test(
      'a non-map body leaves the message empty',
      () => expect(
        executor.execute<void>(
          () async => throw _badResponse(422, data: 'Unprocessable'),
        ),
        throwsA(
          isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 422)
              .having((e) => e.message, 'message', isNull),
        ),
      ),
    );

    test(
      'a response-less timeout to ServerException without a code',
      () => expect(
        executor.execute<void>(
          () async => throw DioException.connectionTimeout(
            timeout: const Duration(seconds: 30),
            requestOptions: RequestOptions(path: '/tasks'),
          ),
        ),
        throwsA(
          isA<ServerException>().having(
            (e) => e.statusCode,
            'statusCode',
            isNull,
          ),
        ),
      ),
    );
  });

  test('surfaces an unexpected error unchanged in debug builds', () {
    final error = StateError('bug');

    // Release builds hide it behind DevelopmentException; tests run with
    // asserts enabled, so only the debug branch is observable here.
    expect(
      executor.execute<void>(() async => throw error),
      throwsA(same(error)),
    );
  });
}
