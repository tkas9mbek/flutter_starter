import 'package:flutter/foundation.dart';

/// A dial-code option shown by [CountryCodeField].
@immutable
class CountryCode {
  const CountryCode({
    required this.name,
    required this.dialCode,
    required this.flag,
  });

  final String name;
  final String dialCode;
  final String flag;

  @override
  bool operator ==(Object other) =>
      other is CountryCode && other.dialCode == dialCode && other.name == name;

  @override
  int get hashCode => Object.hash(dialCode, name);
}
