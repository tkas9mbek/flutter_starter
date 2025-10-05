import 'dart:io';

import 'package:flutter/material.dart';

class LanguageOption {
  final String code;
  final String name;

  const LanguageOption(this.code, this.name);

  factory LanguageOption.fromCode(String? code) =>
      languageOptionsAvailable.firstWhere(
        (element) => element.code == code,
        orElse: () => defaultLanguageOption,
      );

  Locale get locale => Locale(code);
}

List<LanguageOption> languageOptionsAvailable = [
  const LanguageOption('ru', 'Русский'),
];

LanguageOption defaultLanguageOption = languageOptionsAvailable.firstWhere(
  (element) => Platform.localeName.split('_').first == element.code,
  orElse: () => languageOptionsAvailable.first,
);
