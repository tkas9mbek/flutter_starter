// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthLoginRequestBody _$AuthLoginRequestBodyFromJson(
  Map<String, dynamic> json,
) => _AuthLoginRequestBody(
  phone: json['phone'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$AuthLoginRequestBodyToJson(
  _AuthLoginRequestBody instance,
) => <String, dynamic>{'phone': instance.phone, 'password': instance.password};
