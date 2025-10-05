// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthRegisterRequestBodyImpl _$$AuthRegisterRequestBodyImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthRegisterRequestBodyImpl(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$AuthRegisterRequestBodyImplToJson(
        _$AuthRegisterRequestBodyImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
    };
