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

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get toLogin {
    return Intl.message(
      'Log In',
      name: 'toLogin',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get toRegister {
    return Intl.message(
      'Register',
      name: 'toRegister',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get toLogout {
    return Intl.message(
      'Log Out',
      name: 'toLogout',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get haveNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'haveNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet`
  String get noTasksYet {
    return Intl.message(
      'No tasks yet',
      name: 'noTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `{title} deleted`
  String taskDeleted(Object title) {
    return Intl.message(
      '$title deleted',
      name: 'taskDeleted',
      desc: '',
      args: [title],
    );
  }

  /// `task`
  String get task {
    return Intl.message(
      'task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `tasks`
  String get tasks_plural {
    return Intl.message(
      'tasks',
      name: 'tasks_plural',
      desc: '',
      args: [],
    );
  }

  /// `tasks`
  String get tasks_many {
    return Intl.message(
      'tasks',
      name: 'tasks_many',
      desc: '',
      args: [],
    );
  }

  /// `Select a date`
  String get selectDate {
    return Intl.message(
      'Select a date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `No tasks for this date`
  String get noTasksForDate {
    return Intl.message(
      'No tasks for this date',
      name: 'noTasksForDate',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Theme switching coming soon!`
  String get themeSwitchingComingSoon {
    return Intl.message(
      'Theme switching coming soon!',
      name: 'themeSwitchingComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions coming soon!`
  String get termsComingSoon {
    return Intl.message(
      'Terms and Conditions coming soon!',
      name: 'termsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy coming soon!`
  String get privacyPolicyComingSoon {
    return Intl.message(
      'Privacy Policy coming soon!',
      name: 'privacyPolicyComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{{count} year old} other{{count} years old}}`
  String yearsOld(int count) {
    return Intl.plural(
      count,
      one: '$count year old',
      other: '$count years old',
      name: 'yearsOld',
      desc: '',
      args: [count],
    );
  }

  /// `Failed to load profile`
  String get failedToLoadProfile {
    return Intl.message(
      'Failed to load profile',
      name: 'failedToLoadProfile',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Logging out...`
  String get loggingOut {
    return Intl.message(
      'Logging out...',
      name: 'loggingOut',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Select your birthday`
  String get selectYourBirthday {
    return Intl.message(
      'Select your birthday',
      name: 'selectYourBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Birthday is required`
  String get birthdayIsRequired {
    return Intl.message(
      'Birthday is required',
      name: 'birthdayIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message(
      'Delete Task',
      name: 'deleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this task?`
  String get deleteTaskConfirmation {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'deleteTaskConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted successfully`
  String get taskDeletedSuccessfully {
    return Intl.message(
      'Task deleted successfully',
      name: 'taskDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete task`
  String get failedToDeleteTask {
    return Intl.message(
      'Failed to delete task',
      name: 'failedToDeleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load task details`
  String get failedToLoadTaskDetails {
    return Intl.message(
      'Failed to load task details',
      name: 'failedToLoadTaskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Not Completed`
  String get notCompleted {
    return Intl.message(
      'Not Completed',
      name: 'notCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
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
      Locale.fromSubtags(languageCode: 'en'),
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
