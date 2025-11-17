import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_register_request_body.freezed.dart';

part 'auth_register_request_body.g.dart';

@Freezed(fromJson: true, toJson: true)
class AuthRegisterRequestBody with _$AuthRegisterRequestBody {
  const factory AuthRegisterRequestBody({
    required String name,
    required String phone,
    required String password,
    required DateTime birthday,
  }) = _AuthRegisterRequestBody;

  factory AuthRegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthRegisterRequestBodyFromJson(json);
}
