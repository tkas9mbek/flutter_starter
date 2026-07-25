// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_phone_codes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemotePhoneCodes _$RemotePhoneCodesFromJson(Map<String, dynamic> json) =>
    _RemotePhoneCodes(
      items: (json['items'] as List<dynamic>)
          .map((e) => PhoneCode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemotePhoneCodesToJson(_RemotePhoneCodes instance) =>
    <String, dynamic>{'items': instance.items};

_PhoneCode _$PhoneCodeFromJson(Map<String, dynamic> json) => _PhoneCode(
  phoneCode: json['phone_code'] as String,
  countryCode: json['country_code'] as String,
  regex: json['regex'] as String,
  name: RemoteLocalizedText.fromJson(json['name'] as Map<String, dynamic>),
  mask: json['mask'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$PhoneCodeToJson(_PhoneCode instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'country_code': instance.countryCode,
      'regex': instance.regex,
      'name': instance.name,
      'mask': instance.mask,
      'icon': instance.icon,
    };
