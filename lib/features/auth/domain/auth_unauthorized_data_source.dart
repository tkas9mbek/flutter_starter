import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';

abstract class AuthUnauthorizedDataSource {
  Future<AuthToken> login(AuthLoginRequestBody body);

  Future<AuthToken> register(AuthRegisterRequestBody body);
}
