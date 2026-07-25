import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_verify_otp_request_body.freezed.dart';

part 'auth_verify_otp_request_body.g.dart';

/// Body for `POST /auth/verify-otp` — confirms the code sent to [phone]
/// and completes authentication.
@Freezed(fromJson: true, toJson: true)
abstract class AuthVerifyOtpRequestBody with _$AuthVerifyOtpRequestBody {
  const factory AuthVerifyOtpRequestBody({
    required String phone,
    required String otp,
  }) = _AuthVerifyOtpRequestBody;

  factory AuthVerifyOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthVerifyOtpRequestBodyFromJson(json);
}
