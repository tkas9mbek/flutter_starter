import 'package:freezed_annotation/freezed_annotation.dart';

/// Locale-keyed text payload used inside remote config entries,
/// e.g. `{"en": "Kyrgyzstan", "ru": "Кыргызстан"}`.
@immutable
class RemoteLocalizedText {
  const RemoteLocalizedText(this.values);

  factory RemoteLocalizedText.fromJson(Map<String, dynamic> json) =>
      RemoteLocalizedText(
        json.map((key, value) => MapEntry(key, value.toString())),
      );

  final Map<String, String> values;

  /// Text for [languageCode], falling back to `en`, then `ru`, then the
  /// first available translation.
  String resolve(String languageCode) =>
      values[languageCode] ??
      values['en'] ??
      values['ru'] ??
      (values.isEmpty ? '' : values.values.first);

  Map<String, dynamic> toJson() => values;

  @override
  bool operator ==(Object other) =>
      other is RemoteLocalizedText &&
      other.values.length == values.length &&
      other.values.entries.every((entry) => values[entry.key] == entry.value);

  @override
  int get hashCode => Object.hashAllUnordered(
    values.entries.map((entry) => Object.hash(entry.key, entry.value)),
  );
}
