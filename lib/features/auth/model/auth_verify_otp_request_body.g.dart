// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_verify_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthVerifyOtpRequestBody _$AuthVerifyOtpRequestBodyFromJson(
  Map<String, dynamic> json,
) => _AuthVerifyOtpRequestBody(
  phone: json['phone'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$AuthVerifyOtpRequestBodyToJson(
  _AuthVerifyOtpRequestBody instance,
) => <String, dynamic>{'phone': instance.phone, 'otp': instance.otp};
