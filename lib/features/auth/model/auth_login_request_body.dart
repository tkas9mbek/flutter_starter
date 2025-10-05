import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_request_body.freezed.dart';

part 'auth_login_request_body.g.dart';

@Freezed(fromJson: true, toJson: true)
class AuthLoginRequestBody with _$AuthLoginRequestBody {
  const factory AuthLoginRequestBody({
    required String phone,
    required String password,
  }) = _AuthLoginRequestBody;

  factory AuthLoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestBodyFromJson(json);
}
