import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter/core/remote_config/model/remote_localized_text.dart';

part 'remote_phone_codes.freezed.dart';

part 'remote_phone_codes.g.dart';

@Freezed(fromJson: true, toJson: true)
abstract class RemotePhoneCodes
    with _$RemotePhoneCodes
    implements RemoteConfigEntry {
  const factory RemotePhoneCodes({required List<PhoneCode> items}) =
      _RemotePhoneCodes;

  factory RemotePhoneCodes.fromJson(Map<String, dynamic> json) =>
      _$RemotePhoneCodesFromJson(json);
}

@Freezed(fromJson: true, toJson: true)
abstract class PhoneCode with _$PhoneCode {
  const factory PhoneCode({
    @JsonKey(name: 'phone_code') required String phoneCode,
    @JsonKey(name: 'country_code') required String countryCode,
    required String regex,
    required RemoteLocalizedText name,
    required String mask,
    required String icon,
  }) = _PhoneCode;

  const PhoneCode._();

  factory PhoneCode.fromJson(Map<String, dynamic> json) =>
      _$PhoneCodeFromJson(json);

  String get dialCode => '+${phoneCode.trim()}';
}
