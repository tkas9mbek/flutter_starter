import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/data/api_auth_authorized_data_source.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ApiAuthAuthorizedDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiAuthAuthorizedDataSource(mockApiClient);
  });

  group('logout', () {
    test('posts to /auth/logout', () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/logout',
        ),
      ).thenAnswer((_) async {});

      await dataSource.logout();

      verify(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/logout',
        ),
      ).called(1);
    });

    test('propagates a client failure', () {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/logout',
        ),
      ).thenThrow(Exception('Network error'));

      expect(() => dataSource.logout(), throwsA(isA<Exception>()));
    });
  });
}
