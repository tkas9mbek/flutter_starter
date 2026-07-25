import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';

part 'remote_general_settings.freezed.dart';

part 'remote_general_settings.g.dart';

@Freezed(fromJson: true, toJson: true)
abstract class RemoteGeneralSettings
    with _$RemoteGeneralSettings
    implements RemoteConfigEntry {
  const factory RemoteGeneralSettings({required AppVersion appVersion}) =
      _RemoteGeneralSettings;

  factory RemoteGeneralSettings.fromJson(Map<String, dynamic> json) =>
      _$RemoteGeneralSettingsFromJson(json);
}

@Freezed(fromJson: true, toJson: true)
abstract class AppVersion with _$AppVersion {
  const factory AppVersion({
    required AppVersionPlatform minimal,
    required AppVersionPlatform current,
  }) = _AppVersion;

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
}

@Freezed(fromJson: true, toJson: true)
abstract class AppVersionPlatform with _$AppVersionPlatform {
  const factory AppVersionPlatform({
    required String ios,
    required String android,
  }) = _AppVersionPlatform;

  factory AppVersionPlatform.fromJson(Map<String, dynamic> json) =>
      _$AppVersionPlatformFromJson(json);
}
