import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

abstract final class MockAuthScenarios {
  static const token = AuthToken(
    accessToken: 'mock_access_token_eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
    refreshToken: 'mock_refresh_token_dGhpcyBpcyBhIG1vY2sgcmVmcmVzaCB0b2tlbg',
  );

  /// Sentinel: verifying this code is refused.
  static const wrongOtp = '0000';

  static AppException wrongOtpRefusal() =>
      const UnauthorizedException(message: 'Invalid verification code');
}
