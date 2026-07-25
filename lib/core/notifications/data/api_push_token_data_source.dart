import 'package:starter/core/notifications/domain/push_token_data_source.dart';
import 'package:starter/core/notifications/model/push_token_request.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class ApiPushTokenDataSource implements PushTokenDataSource {
  const ApiPushTokenDataSource(this._client);

  final ApiClient _client;

  @override
  Future<void> postPushToken(String token) => _client.requestVoid(
    method: HttpMethod.post,
    path: '/notifications/push-token',
    body: PushTokenRequest(
      systemType: 'GOOGLE_FIREBASE',
      token: token,
    ).toJson(),
  );
}
