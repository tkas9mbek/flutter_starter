// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PushTokenRequest _$PushTokenRequestFromJson(Map<String, dynamic> json) =>
    _PushTokenRequest(
      systemType: json['systemType'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$PushTokenRequestToJson(_PushTokenRequest instance) =>
    <String, dynamic>{
      'systemType': instance.systemType,
      'token': instance.token,
    };
