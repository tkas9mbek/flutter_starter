// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthRegisterRequestBody _$AuthRegisterRequestBodyFromJson(
  Map<String, dynamic> json,
) => _AuthRegisterRequestBody(
  name: json['name'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String,
  birthday: DateTime.parse(json['birthday'] as String),
);

Map<String, dynamic> _$AuthRegisterRequestBodyToJson(
  _AuthRegisterRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'password': instance.password,
  'birthday': instance.birthday.toIso8601String(),
};
