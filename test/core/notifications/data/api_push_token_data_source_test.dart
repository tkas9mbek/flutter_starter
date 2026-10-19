import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/core/notifications/data/api_push_token_data_source.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockApiClient;
  late ApiPushTokenDataSource dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiPushTokenDataSource(mockApiClient);
  });

  test(
    'posts the serialized PushTokenRequest to the push-token endpoint',
    () async {
      when(
        () => mockApiClient.requestVoid(
          method: HttpMethod.post,
          path: '/notifications/push-token',
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async {});

      await dataSource.postPushToken('device-token');

      final body =
          verify(
                () => mockApiClient.requestVoid(
                  method: HttpMethod.post,
                  path: '/notifications/push-token',
                  body: captureAny(named: 'body'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(body, {'systemType': 'GOOGLE_FIREBASE', 'token': 'device-token'});
    },
  );

  test('propagates an API failure', () {
    when(
      () => mockApiClient.requestVoid(
        method: HttpMethod.post,
        path: '/notifications/push-token',
        body: any(named: 'body'),
      ),
    ).thenThrow(const NoInternetException());

    expect(
      () => dataSource.postPushToken('device-token'),
      throwsA(isA<NoInternetException>()),
    );
  });
}
