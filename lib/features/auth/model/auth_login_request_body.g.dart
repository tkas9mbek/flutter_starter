// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthLoginRequestBodyImpl _$$AuthLoginRequestBodyImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthLoginRequestBodyImpl(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$AuthLoginRequestBodyImplToJson(
        _$AuthLoginRequestBodyImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
    };
