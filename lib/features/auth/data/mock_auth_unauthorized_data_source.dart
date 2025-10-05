import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';

const _mockToken = AuthToken(
  accessToken: 'mock_access_token',
  refreshToken: 'mock_refresh_token',
);

class MockAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  const MockAuthUnauthorizedDataSource();

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockToken;
  }

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockToken;
  }
}
