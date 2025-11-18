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

  /// `Нет данных`
  String get noDataAvailable {
    return Intl.message(
      'Нет данных',
      name: 'noDataAvailable',
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

  /// `Попробуйте обновить страницу`
  String get tryRefreshPage {
    return Intl.message(
      'Попробуйте обновить страницу',
      name: 'tryRefreshPage',
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
