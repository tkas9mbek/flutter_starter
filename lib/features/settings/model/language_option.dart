import 'dart:io';

import 'package:flutter/material.dart';

class LanguageOption {
  const LanguageOption(this.code, this.name);

  factory LanguageOption.fromCode(String? code) =>
      languageOptionsAvailable.firstWhere(
        (element) => element.code == code,
        orElse: () => defaultLanguageOption,
      );

  final String code;
  final String name;

  Locale get locale => Locale(code);
}

List<LanguageOption> languageOptionsAvailable = [
  const LanguageOption('ru', 'Русский'),
  const LanguageOption('en', 'English'),
];

LanguageOption defaultLanguageOption = languageOptionsAvailable.firstWhere(
  (element) => Platform.localeName.split('_').first == element.code,
  orElse: () => languageOptionsAvailable.first,
);
