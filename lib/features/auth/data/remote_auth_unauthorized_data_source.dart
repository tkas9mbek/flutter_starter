import 'package:starter/features/auth/data/auth_service.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';

class RemoteAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  RemoteAuthUnauthorizedDataSource(this._authService);

  final AuthService _authService;

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) => _authService.login(body);

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) =>
      _authService.register(body);
}
