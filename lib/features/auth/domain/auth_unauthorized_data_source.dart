import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';

abstract class AuthUnauthorizedDataSource {
  Future<AuthToken> login(AuthLoginRequestBody body);

  Future<AuthToken> register(AuthRegisterRequestBody body);

  /// Sends a one-time code to the phone in [body]. Confirm it with
  /// [verifyOtp].
  Future<void> requestOtp(AuthOtpRequestBody body);

  Future<AuthToken> verifyOtp(AuthVerifyOtpRequestBody body);
}
