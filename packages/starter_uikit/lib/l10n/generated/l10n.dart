// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class UiLocalizer {
  UiLocalizer();

  static UiLocalizer? _current;

  static UiLocalizer get current {
    assert(_current != null,
        'No instance of UiLocalizer was loaded. Try to initialize the UiLocalizer delegate before accessing UiLocalizer.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<UiLocalizer> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = UiLocalizer();
      UiLocalizer._current = instance;

      return instance;
    });
  }

  static UiLocalizer of(BuildContext context) {
    final instance = UiLocalizer.maybeOf(context);
    assert(instance != null,
        'No instance of UiLocalizer present in the widget tree. Did you add UiLocalizer.delegate in localizationsDelegates?');
    return instance!;
  }

  static UiLocalizer? maybeOf(BuildContext context) {
    return Localizations.of<UiLocalizer>(context, UiLocalizer);
  }

  /// `Назад`
  String get back {
    return Intl.message(
      'Назад',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Июнь`
  String get monthJune {
    return Intl.message(
      'Июнь',
      name: 'monthJune',
      desc: '',
      args: [],
    );
  }

  /// `Апрель`
  String get monthApril {
    return Intl.message(
      'Апрель',
      name: 'monthApril',
      desc: '',
      args: [],
    );
  }

  /// `Август`
  String get monthAugust {
    return Intl.message(
      'Август',
      name: 'monthAugust',
      desc: '',
      args: [],
    );
  }

  /// `Декабрь`
  String get monthDecember {
    return Intl.message(
      'Декабрь',
      name: 'monthDecember',
      desc: '',
      args: [],
    );
  }

  /// `Февраль`
  String get monthFebruary {
    return Intl.message(
      'Февраль',
      name: 'monthFebruary',
      desc: '',
      args: [],
    );
  }

  /// `Январь`
  String get monthJanuary {
    return Intl.message(
      'Январь',
      name: 'monthJanuary',
      desc: '',
      args: [],
    );
  }

  /// `Июнь`
  String get montJune {
    return Intl.message(
      'Июнь',
      name: 'montJune',
      desc: '',
      args: [],
    );
  }

  /// `Июль`
  String get monthJuly {
    return Intl.message(
      'Июль',
      name: 'monthJuly',
      desc: '',
      args: [],
    );
  }

  /// `Март`
  String get monthMarch {
    return Intl.message(
      'Март',
      name: 'monthMarch',
      desc: '',
      args: [],
    );
  }

  /// `Май`
  String get monthMay {
    return Intl.message(
      'Май',
      name: 'monthMay',
      desc: '',
      args: [],
    );
  }

  /// `Ноябрь`
  String get monthNovember {
    return Intl.message(
      'Ноябрь',
      name: 'monthNovember',
      desc: '',
      args: [],
    );
  }

  /// `Октябрь`
  String get monthOctober {
    return Intl.message(
      'Октябрь',
      name: 'monthOctober',
      desc: '',
      args: [],
    );
  }

  /// `Сентябрь`
  String get monthSeptember {
    return Intl.message(
      'Сентябрь',
      name: 'monthSeptember',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать`
  String get toSelect {
    return Intl.message(
      'Выбрать',
      name: 'toSelect',
      desc: '',
      args: [],
    );
  }

  /// `Повторить`
  String get retry {
    return Intl.message(
      'Повторить',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Готово`
  String get done {
    return Intl.message(
      'Готово',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Неожиданная ошибка`
  String get errorMessageUnexpectedError {
    return Intl.message(
      'Неожиданная ошибка',
      name: 'errorMessageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте соединение и попробуйте снова`
  String get errorMessageCheckAndTryLater {
    return Intl.message(
      'Проверьте соединение и попробуйте снова',
      name: 'errorMessageCheckAndTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Попробуйте обновить страницу`
  String get tryRefreshPage {
    return Intl.message(
      'Попробуйте обновить страницу',
      name: 'tryRefreshPage',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancellation {
    return Intl.message(
      'Отмена',
      name: 'cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Галерея`
  String get gallery {
    return Intl.message(
      'Галерея',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Камера`
  String get camera {
    return Intl.message(
      'Камера',
      name: 'camera',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<UiLocalizer> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<UiLocalizer> load(Locale locale) => UiLocalizer.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
