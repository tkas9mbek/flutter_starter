import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

Response<Object?> _response(int statusCode, Object? data) => Response(
  requestOptions: RequestOptions(path: '/x'),
  statusCode: statusCode,
  data: data,
);

void main() {
  test('exceptions print their name and data instead of Instance of', () {
    expect(const NoInternetException().toString(), 'NoInternet');
    expect(
      const ServerException(statusCode: 404, message: 'Not found').toString(),
      'Server(statusCode: 404, message: Not found)',
    );
    expect(
      const UnauthorizedException(message: 'Expired').toString(),
      'Unauthorized(message: Expired)',
    );
    expect(const DevelopmentException().toString(), 'Development');
  });

  test('every subtype reports its name, retryability and payload', () {
    final unknown = UnknownException(
      error: StateError('boom'),
      stackTrace: StackTrace.empty,
    );
    final cases = <(AppException, String, bool, String)>[
      (const NoInternetException(), 'NoInternet', true, 'NoInternet'),
      (
        const ServerException(statusCode: 502, message: 'Bad gateway'),
        'Server',
        true,
        'Server(statusCode: 502, message: Bad gateway)',
      ),
      (
        const UnauthorizedException(),
        'Unauthorized',
        false,
        'Unauthorized(message: null)',
      ),
      (
        const ForbiddenException(message: 'No access'),
        'Forbidden',
        false,
        'Forbidden(message: No access)',
      ),
      (
        const InternalServerErrorException(message: 'Down'),
        'InternalServerError',
        true,
        'InternalServerError(message: Down)',
      ),
      (unknown, 'Unknown', false, 'Unknown(Bad state: boom)'),
      (const DevelopmentException(), 'Development', false, 'Development'),
      (
        const UrlLaunchFailedException(),
        'UrlLaunchFailed',
        false,
        'UrlLaunchFailed',
      ),
    ];

    for (final (exception, name, canRetry, printed) in cases) {
      expect(exception.name, name);
      expect(exception.canRetry, canRetry, reason: name);
      expect(exception.toString(), printed);
    }
  });

  group('fromDioResponse', () {
    test('maps 401, 403 and 500 to their dedicated subtypes', () {
      expect(
        AppException.fromDioResponse(
          statusCode: 401,
          response: _response(401, {'message': 'Expired'}),
        ),
        isA<UnauthorizedException>().having(
          (e) => e.message,
          'message',
          'Expired',
        ),
      );
      expect(
        AppException.fromDioResponse(
          statusCode: 403,
          response: _response(403, {'message': 'Denied'}),
        ),
        isA<ForbiddenException>().having((e) => e.message, 'message', 'Denied'),
      );
      expect(
        AppException.fromDioResponse(
          statusCode: 500,
          response: _response(500, {'message': 'Oops'}),
        ),
        isA<InternalServerErrorException>().having(
          (e) => e.message,
          'message',
          'Oops',
        ),
      );
    });

    test(
      'maps any other status to ServerException',
      () => expect(
        AppException.fromDioResponse(
          statusCode: 409,
          response: _response(409, {'message': 'Conflict'}),
        ),
        isA<ServerException>()
            .having((e) => e.statusCode, 'statusCode', 409)
            .having((e) => e.message, 'message', 'Conflict'),
      ),
    );

    test(
      'ignores a body that is not a JSON object',
      () => expect(
        AppException.fromDioResponse(
          statusCode: 500,
          response: _response(500, '<html>Down</html>'),
        ),
        isA<InternalServerErrorException>().having(
          (e) => e.message,
          'message',
          isNull,
        ),
      ),
    );

    test(
      'without a response yields a code-less ServerException',
      () => expect(
        AppException.fromDioResponse(),
        isA<ServerException>()
            .having((e) => e.statusCode, 'statusCode', isNull)
            .having((e) => e.message, 'message', isNull),
      ),
    );
  });
}
