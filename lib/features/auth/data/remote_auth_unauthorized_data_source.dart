import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class RemoteAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  const RemoteAuthUnauthorizedDataSource(this._client);

  final ApiClient _client;

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) =>
      _client.requestJson<AuthToken>(
        method: HttpMethod.post,
        path: '/auth/login',
        body: body.toJson(),
        fromJson: AuthToken.fromJson,
      );

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) =>
      _client.requestJson<AuthToken>(
        method: HttpMethod.post,
        path: '/auth/register',
        body: body.toJson(),
        fromJson: AuthToken.fromJson,
      );
}
