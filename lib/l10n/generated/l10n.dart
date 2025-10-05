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

class Localizer {
  Localizer();

  static Localizer? _current;

  static Localizer get current {
    assert(_current != null,
        'No instance of Localizer was loaded. Try to initialize the Localizer delegate before accessing Localizer.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localizer> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localizer();
      Localizer._current = instance;

      return instance;
    });
  }

  static Localizer of(BuildContext context) {
    final instance = Localizer.maybeOf(context);
    assert(instance != null,
        'No instance of Localizer present in the widget tree. Did you add Localizer.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localizer? maybeOf(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }

  /// `Вход`
  String get login {
    return Intl.message(
      'Вход',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get signUp {
    return Intl.message(
      'Регистрация',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Номер телефона`
  String get phoneNumber {
    return Intl.message(
      'Номер телефона',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона`
  String get enterPhoneNumber {
    return Intl.message(
      'Введите номер телефона',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Введите пароль`
  String get enterPassword {
    return Intl.message(
      'Введите пароль',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get toLogin {
    return Intl.message(
      'Войти',
      name: 'toLogin',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get toRegister {
    return Intl.message(
      'Зарегистрироваться',
      name: 'toRegister',
      desc: '',
      args: [],
    );
  }

  /// `Выйти`
  String get toLogout {
    return Intl.message(
      'Выйти',
      name: 'toLogout',
      desc: '',
      args: [],
    );
  }

  /// `Календарь`
  String get calendar {
    return Intl.message(
      'Календарь',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Нет аккаунта?`
  String get haveNoAccount {
    return Intl.message(
      'Нет аккаунта?',
      name: 'haveNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Уже есть аккаунт?`
  String get haveAccount {
    return Intl.message(
      'Уже есть аккаунт?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localizer> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localizer> load(Locale locale) => Localizer.load(locale);
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
