// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_general_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteGeneralSettings _$RemoteGeneralSettingsFromJson(
  Map<String, dynamic> json,
) => _RemoteGeneralSettings(
  appVersion: AppVersion.fromJson(json['appVersion'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RemoteGeneralSettingsToJson(
  _RemoteGeneralSettings instance,
) => <String, dynamic>{'appVersion': instance.appVersion};

_AppVersion _$AppVersionFromJson(Map<String, dynamic> json) => _AppVersion(
  minimal: AppVersionPlatform.fromJson(json['minimal'] as Map<String, dynamic>),
  current: AppVersionPlatform.fromJson(json['current'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppVersionToJson(_AppVersion instance) =>
    <String, dynamic>{'minimal': instance.minimal, 'current': instance.current};

_AppVersionPlatform _$AppVersionPlatformFromJson(Map<String, dynamic> json) =>
    _AppVersionPlatform(
      ios: json['ios'] as String,
      android: json['android'] as String,
    );

Map<String, dynamic> _$AppVersionPlatformToJson(_AppVersionPlatform instance) =>
    <String, dynamic>{'ios': instance.ios, 'android': instance.android};
