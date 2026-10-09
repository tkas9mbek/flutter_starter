import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

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
}
