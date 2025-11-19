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

  /// `Задачи`
  String get tasks {
    return Intl.message(
      'Задачи',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Пока нет задач`
  String get noTasksYet {
    return Intl.message(
      'Пока нет задач',
      name: 'noTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `{title} удалена`
  String taskDeleted(Object title) {
    return Intl.message(
      '$title удалена',
      name: 'taskDeleted',
      desc: '',
      args: [title],
    );
  }

  /// `задача`
  String get task {
    return Intl.message(
      'задача',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `задачи`
  String get tasks_plural {
    return Intl.message(
      'задачи',
      name: 'tasks_plural',
      desc: '',
      args: [],
    );
  }

  /// `задач`
  String get tasks_many {
    return Intl.message(
      'задач',
      name: 'tasks_many',
      desc: '',
      args: [],
    );
  }

  /// `Выберите дату`
  String get selectDate {
    return Intl.message(
      'Выберите дату',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Нет задач на эту дату`
  String get noTasksForDate {
    return Intl.message(
      'Нет задач на эту дату',
      name: 'noTasksForDate',
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

  /// `Завтра`
  String get tomorrow {
    return Intl.message(
      'Завтра',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Внешний вид`
  String get appearance {
    return Intl.message(
      'Внешний вид',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Тема`
  String get theme {
    return Intl.message(
      'Тема',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Светлая`
  String get light {
    return Intl.message(
      'Светлая',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Тёмная`
  String get dark {
    return Intl.message(
      'Тёмная',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Переключение темы скоро появится!`
  String get themeSwitchingComingSoon {
    return Intl.message(
      'Переключение темы скоро появится!',
      name: 'themeSwitchingComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Язык`
  String get language {
    return Intl.message(
      'Язык',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Выберите язык`
  String get selectLanguage {
    return Intl.message(
      'Выберите язык',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `О приложении`
  String get about {
    return Intl.message(
      'О приложении',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Версия`
  String get version {
    return Intl.message(
      'Версия',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Условия использования`
  String get termsAndConditions {
    return Intl.message(
      'Условия использования',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Условия использования скоро появятся!`
  String get termsComingSoon {
    return Intl.message(
      'Условия использования скоро появятся!',
      name: 'termsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Политика конфиденциальности`
  String get privacyPolicy {
    return Intl.message(
      'Политика конфиденциальности',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Политика конфиденциальности скоро появится!`
  String get privacyPolicyComingSoon {
    return Intl.message(
      'Политика конфиденциальности скоро появится!',
      name: 'privacyPolicyComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `День рождения`
  String get birthday {
    return Intl.message(
      'День рождения',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Возраст`
  String get age {
    return Intl.message(
      'Возраст',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{{count} год} few{{count} года} other{{count} лет}}`
  String yearsOld(int count) {
    return Intl.plural(
      count,
      one: '$count год',
      few: '$count года',
      other: '$count лет',
      name: 'yearsOld',
      desc: '',
      args: [count],
    );
  }

  /// `Не удалось загрузить профиль`
  String get failedToLoadProfile {
    return Intl.message(
      'Не удалось загрузить профиль',
      name: 'failedToLoadProfile',
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

  /// `Выход из системы...`
  String get loggingOut {
    return Intl.message(
      'Выход из системы...',
      name: 'loggingOut',
      desc: '',
      args: [],
    );
  }

  /// `Обновить`
  String get refresh {
    return Intl.message(
      'Обновить',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get name {
    return Intl.message(
      'Имя',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Введите ваше имя`
  String get enterYourName {
    return Intl.message(
      'Введите ваше имя',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Выберите дату рождения`
  String get selectYourBirthday {
    return Intl.message(
      'Выберите дату рождения',
      name: 'selectYourBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения обязательна`
  String get birthdayIsRequired {
    return Intl.message(
      'Дата рождения обязательна',
      name: 'birthdayIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Детали задачи`
  String get taskDetails {
    return Intl.message(
      'Детали задачи',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Удалить задачу`
  String get deleteTask {
    return Intl.message(
      'Удалить задачу',
      name: 'deleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Вы уверены, что хотите удалить эту задачу?`
  String get deleteTaskConfirmation {
    return Intl.message(
      'Вы уверены, что хотите удалить эту задачу?',
      name: 'deleteTaskConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Задача успешно удалена`
  String get taskDeletedSuccessfully {
    return Intl.message(
      'Задача успешно удалена',
      name: 'taskDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось удалить задачу`
  String get failedToDeleteTask {
    return Intl.message(
      'Не удалось удалить задачу',
      name: 'failedToDeleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось загрузить детали задачи`
  String get failedToLoadTaskDetails {
    return Intl.message(
      'Не удалось загрузить детали задачи',
      name: 'failedToLoadTaskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Время начала`
  String get startTime {
    return Intl.message(
      'Время начала',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Время окончания`
  String get endTime {
    return Intl.message(
      'Время окончания',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get description {
    return Intl.message(
      'Описание',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Завершена`
  String get completed {
    return Intl.message(
      'Завершена',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Не завершена`
  String get notCompleted {
    return Intl.message(
      'Не завершена',
      name: 'notCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Статус`
  String get status {
    return Intl.message(
      'Статус',
      name: 'status',
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
