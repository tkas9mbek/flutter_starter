import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

const _mockToken = AuthToken(
  accessToken: 'mock_access_token_eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  refreshToken: 'mock_refresh_token_dGhpcyBpcyBhIG1vY2sgcmVmcmVzaCB0b2tlbg',
);

class MockAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  const MockAuthUnauthorizedDataSource();

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) async {
    await Future.delayed(const Duration(seconds: 2));

    return _mockToken;
  }

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) async {
    await Future.delayed(const Duration(seconds: 2));

    return _mockToken;
  }

  @override
  Future<void> requestOtp(AuthOtpRequestBody body) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<AuthToken> verifyOtp(AuthVerifyOtpRequestBody body) async {
    await Future.delayed(const Duration(seconds: 2));

    // '0000' simulates a wrong code.
    if (body.otp == '0000') {
      throw const UnauthorizedException();
    }

    return _mockToken;
  }
}
