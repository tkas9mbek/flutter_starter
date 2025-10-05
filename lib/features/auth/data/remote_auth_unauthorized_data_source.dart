import 'package:starter/features/auth/data/auth_api.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';

class RemoteAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  RemoteAuthUnauthorizedDataSource(this._authApi);

  final AuthApi _authApi;

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) => _authApi.login(body);

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) =>
      _authApi.register(body);
}
