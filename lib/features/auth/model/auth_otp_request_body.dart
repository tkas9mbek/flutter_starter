import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_otp_request_body.freezed.dart';

part 'auth_otp_request_body.g.dart';

/// Body for `POST /auth/request-otp`. The code is sent to [phone].
@Freezed(fromJson: true, toJson: true)
abstract class AuthOtpRequestBody with _$AuthOtpRequestBody {
  const factory AuthOtpRequestBody({required String phone}) =
      _AuthOtpRequestBody;

  factory AuthOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthOtpRequestBodyFromJson(json);
}
