import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/data/api_auth_authorized_data_source.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

import '../model/auth_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ApiAuthAuthorizedDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiAuthAuthorizedDataSource(mockApiClient);
  });

  group('logout', () {
    test('posts to /auth/logout with the given token', () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/logout',
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.logout(AuthMockModels.authToken);

      final headers =
          verify(
                () => mockApiClient.requestVoid(
                  method: HttpMethod.post,
                  path: '/auth/logout',
                  headers: captureAny(named: 'headers'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(
        headers['Authorization'],
        'Bearer ${AuthMockModels.authToken.accessToken}',
      );
    });

    test('propagates a client failure', () {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/auth/logout',
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.logout(AuthMockModels.authToken),
        throwsA(isA<Exception>()),
      );
    });
  });
}
