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

class ToolkitLocalizer {
  ToolkitLocalizer();

  static ToolkitLocalizer? _current;

  static ToolkitLocalizer get current {
    assert(_current != null,
        'No instance of ToolkitLocalizer was loaded. Try to initialize the ToolkitLocalizer delegate before accessing ToolkitLocalizer.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ToolkitLocalizer> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ToolkitLocalizer();
      ToolkitLocalizer._current = instance;

      return instance;
    });
  }

  static ToolkitLocalizer of(BuildContext context) {
    final instance = ToolkitLocalizer.maybeOf(context);
    assert(instance != null,
        'No instance of ToolkitLocalizer present in the widget tree. Did you add ToolkitLocalizer.delegate in localizationsDelegates?');
    return instance!;
  }

  static ToolkitLocalizer? maybeOf(BuildContext context) {
    return Localizations.of<ToolkitLocalizer>(context, ToolkitLocalizer);
  }

  /// `Нет подключения к интернету`
  String get errorMessageNoInternetConnection {
    return Intl.message(
      'Нет подключения к интернету',
      name: 'errorMessageNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Нет соединения с сервером`
  String get errorMessageNoConnection {
    return Intl.message(
      'Нет соединения с сервером',
      name: 'errorMessageNoConnection',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось подключиться к серверу. Это может быть из-за проблем с сервером или вашим интернетом.`
  String get errorMessageCouldNotConnectServer {
    return Intl.message(
      'Не удалось подключиться к серверу. Это может быть из-за проблем с сервером или вашим интернетом.',
      name: 'errorMessageCouldNotConnectServer',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте ваше подключение к сети и попробуйте снова.`
  String get errorMessageCheckAndTryLater {
    return Intl.message(
      'Проверьте ваше подключение к сети и попробуйте снова.',
      name: 'errorMessageCheckAndTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка приложения! Сообщите разработчикам.`
  String get errorMessageMobileBug {
    return Intl.message(
      'Ошибка приложения! Сообщите разработчикам.',
      name: 'errorMessageMobileBug',
      desc: '',
      args: [],
    );
  }

  /// `Запрос не выполнен, попробуйте позже`
  String get errorMessageDefaultRequestError {
    return Intl.message(
      'Запрос не выполнен, попробуйте позже',
      name: 'errorMessageDefaultRequestError',
      desc: '',
      args: [],
    );
  }

  /// `Что-то пошло не так.`
  String get errorMessageUnexpectedError {
    return Intl.message(
      'Что-то пошло не так.',
      name: 'errorMessageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, войдите в систему, чтобы продолжить`
  String get errorMessageAuthRequired {
    return Intl.message(
      'Пожалуйста, войдите в систему, чтобы продолжить',
      name: 'errorMessageAuthRequired',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет прав для просмотра этой страницы.`
  String get errorMessageNoRightsToView {
    return Intl.message(
      'У вас нет прав для просмотра этой страницы.',
      name: 'errorMessageNoRightsToView',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет прав для выполнения этого действия.`
  String get errorMessageNoRightsToPerform {
    return Intl.message(
      'У вас нет прав для выполнения этого действия.',
      name: 'errorMessageNoRightsToPerform',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка при выполнении запроса`
  String get errorMessageErrorWhileRequesting {
    return Intl.message(
      'Ошибка при выполнении запроса',
      name: 'errorMessageErrorWhileRequesting',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка при открытии ссылки`
  String get errorMessageUrlLaunchError {
    return Intl.message(
      'Ошибка при открытии ссылки',
      name: 'errorMessageUrlLaunchError',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, предоставьте необходимые разрешения для продолжения работы`
  String get errorMessagePermissionDeniedSnackbar {
    return Intl.message(
      'Пожалуйста, предоставьте необходимые разрешения для продолжения работы',
      name: 'errorMessagePermissionDeniedSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Технические работы на сервере`
  String get errorMessageServerError {
    return Intl.message(
      'Технические работы на сервере',
      name: 'errorMessageServerError',
      desc: '',
      args: [],
    );
  }

  /// `Извините за неудобства, сервер временно недоступен. Попробуйте позже.`
  String get errorMessageServerInternalError {
    return Intl.message(
      'Извините за неудобства, сервер временно недоступен. Попробуйте позже.',
      name: 'errorMessageServerInternalError',
      desc: '',
      args: [],
    );
  }

  /// `Расписание пусто`
  String get errorMessageEmptySchedule {
    return Intl.message(
      'Расписание пусто',
      name: 'errorMessageEmptySchedule',
      desc: '',
      args: [],
    );
  }

  /// `Перейдите в профиль и заполните расписание`
  String get errorMessageEmptyScheduleFillInProfile {
    return Intl.message(
      'Перейдите в профиль и заполните расписание',
      name: 'errorMessageEmptyScheduleFillInProfile',
      desc: '',
      args: [],
    );
  }

  /// `Обязательное поле`
  String get errorRequiredField {
    return Intl.message(
      'Обязательное поле',
      name: 'errorRequiredField',
      desc: '',
      args: [],
    );
  }

  /// `Например, +7 (123) 456-78-90`
  String get errorInvalidPhoneFormat {
    return Intl.message(
      'Например, +7 (123) 456-78-90',
      name: 'errorInvalidPhoneFormat',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, введите свой номер телефона`
  String get errorPhoneRequired {
    return Intl.message(
      'Пожалуйста, введите свой номер телефона',
      name: 'errorPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Введите только латинские буквы и цифры`
  String get errorInvalidLatinAlphanumeric {
    return Intl.message(
      'Введите только латинские буквы и цифры',
      name: 'errorInvalidLatinAlphanumeric',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать не менее {minLength} символов`
  String errorPasswordMinLength(Object minLength) {
    return Intl.message(
      'Пароль должен содержать не менее $minLength символов',
      name: 'errorPasswordMinLength',
      desc: '',
      args: [minLength],
    );
  }

  /// `Пароль должен содержать хотя бы одну заглавную букву`
  String get errorPasswordUppercase {
    return Intl.message(
      'Пароль должен содержать хотя бы одну заглавную букву',
      name: 'errorPasswordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать хотя бы одну строчную букву`
  String get errorPasswordLowercase {
    return Intl.message(
      'Пароль должен содержать хотя бы одну строчную букву',
      name: 'errorPasswordLowercase',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать хотя бы одну цифру`
  String get errorPasswordDigit {
    return Intl.message(
      'Пароль должен содержать хотя бы одну цифру',
      name: 'errorPasswordDigit',
      desc: '',
      args: [],
    );
  }

  /// `Пароль должен содержать хотя бы один специальный символ`
  String get errorPasswordSpecialChar {
    return Intl.message(
      'Пароль должен содержать хотя бы один специальный символ',
      name: 'errorPasswordSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Неверный формат URL`
  String get errorInvalidUrlFormat {
    return Intl.message(
      'Неверный формат URL',
      name: 'errorInvalidUrlFormat',
      desc: '',
      args: [],
    );
  }

  /// `Неверный формат электронной почты`
  String get errorInvalidEmailFormat {
    return Intl.message(
      'Неверный формат электронной почты',
      name: 'errorInvalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `Доступ запрещен`
  String get errorMessagePermissionDenied {
    return Intl.message(
      'Доступ запрещен',
      name: 'errorMessagePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Требуется разрешение`
  String get errorMessagePermissionRequired {
    return Intl.message(
      'Требуется разрешение',
      name: 'errorMessagePermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Сегодня`
  String get today {
    return Intl.message(
      'Сегодня',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Вчера`
  String get yesterday {
    return Intl.message(
      'Вчера',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Завтра`
  String get tomorrow {
    return Intl.message(
      'Завтра',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `{hours} ч. {minutes} мин.`
  String durationInHoursMinutes(Object hours, Object minutes) {
    return Intl.message(
      '$hours ч. $minutes мин.',
      name: 'durationInHoursMinutes',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `{minutes} мин.`
  String durationInMinutes(Object minutes) {
    return Intl.message(
      '$minutes мин.',
      name: 'durationInMinutes',
      desc: '',
      args: [minutes],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ToolkitLocalizer> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ToolkitLocalizer> load(Locale locale) => ToolkitLocalizer.load(locale);
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
