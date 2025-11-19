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

  /// `No internet connection`
  String get errorMessageNoInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'errorMessageNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `No connection to server`
  String get errorMessageNoConnection {
    return Intl.message(
      'No connection to server',
      name: 'errorMessageNoConnection',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to server. This may be due to server issues or your internet connection.`
  String get errorMessageCouldNotConnectServer {
    return Intl.message(
      'Could not connect to server. This may be due to server issues or your internet connection.',
      name: 'errorMessageCouldNotConnectServer',
      desc: '',
      args: [],
    );
  }

  /// `Please check your network connection and try again.`
  String get errorMessageCheckAndTryLater {
    return Intl.message(
      'Please check your network connection and try again.',
      name: 'errorMessageCheckAndTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Application error! Please report to developers.`
  String get errorMessageMobileBug {
    return Intl.message(
      'Application error! Please report to developers.',
      name: 'errorMessageMobileBug',
      desc: '',
      args: [],
    );
  }

  /// `Request failed, please try again later`
  String get errorMessageDefaultRequestError {
    return Intl.message(
      'Request failed, please try again later',
      name: 'errorMessageDefaultRequestError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get errorMessageUnexpectedError {
    return Intl.message(
      'Something went wrong.',
      name: 'errorMessageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to continue`
  String get errorMessageAuthRequired {
    return Intl.message(
      'Please log in to continue',
      name: 'errorMessageAuthRequired',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to view this page.`
  String get errorMessageNoRightsToView {
    return Intl.message(
      'You don\'t have permission to view this page.',
      name: 'errorMessageNoRightsToView',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this action.`
  String get errorMessageNoRightsToPerform {
    return Intl.message(
      'You don\'t have permission to perform this action.',
      name: 'errorMessageNoRightsToPerform',
      desc: '',
      args: [],
    );
  }

  /// `Error while making request`
  String get errorMessageErrorWhileRequesting {
    return Intl.message(
      'Error while making request',
      name: 'errorMessageErrorWhileRequesting',
      desc: '',
      args: [],
    );
  }

  /// `Error opening link`
  String get errorMessageUrlLaunchError {
    return Intl.message(
      'Error opening link',
      name: 'errorMessageUrlLaunchError',
      desc: '',
      args: [],
    );
  }

  /// `Please grant the necessary permissions to continue`
  String get errorMessagePermissionDeniedSnackbar {
    return Intl.message(
      'Please grant the necessary permissions to continue',
      name: 'errorMessagePermissionDeniedSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Server maintenance in progress`
  String get errorMessageServerError {
    return Intl.message(
      'Server maintenance in progress',
      name: 'errorMessageServerError',
      desc: '',
      args: [],
    );
  }

  /// `Sorry for the inconvenience, the server is temporarily unavailable. Please try again later.`
  String get errorMessageServerInternalError {
    return Intl.message(
      'Sorry for the inconvenience, the server is temporarily unavailable. Please try again later.',
      name: 'errorMessageServerInternalError',
      desc: '',
      args: [],
    );
  }

  /// `Schedule is empty`
  String get errorMessageEmptySchedule {
    return Intl.message(
      'Schedule is empty',
      name: 'errorMessageEmptySchedule',
      desc: '',
      args: [],
    );
  }

  /// `Go to profile and fill in the schedule`
  String get errorMessageEmptyScheduleFillInProfile {
    return Intl.message(
      'Go to profile and fill in the schedule',
      name: 'errorMessageEmptyScheduleFillInProfile',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get errorRequiredField {
    return Intl.message(
      'Required field',
      name: 'errorRequiredField',
      desc: '',
      args: [],
    );
  }

  /// `For example, +7 (123) 456-78-90`
  String get errorInvalidPhoneFormat {
    return Intl.message(
      'For example, +7 (123) 456-78-90',
      name: 'errorInvalidPhoneFormat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get errorPhoneRequired {
    return Intl.message(
      'Please enter your phone number',
      name: 'errorPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter only Latin letters and numbers`
  String get errorInvalidLatinAlphanumeric {
    return Intl.message(
      'Enter only Latin letters and numbers',
      name: 'errorInvalidLatinAlphanumeric',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {minLength} characters`
  String errorPasswordMinLength(Object minLength) {
    return Intl.message(
      'Password must be at least $minLength characters',
      name: 'errorPasswordMinLength',
      desc: '',
      args: [minLength],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get errorPasswordUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'errorPasswordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get errorPasswordLowercase {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'errorPasswordLowercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one digit`
  String get errorPasswordDigit {
    return Intl.message(
      'Password must contain at least one digit',
      name: 'errorPasswordDigit',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get errorPasswordSpecialChar {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'errorPasswordSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Invalid URL format`
  String get errorInvalidUrlFormat {
    return Intl.message(
      'Invalid URL format',
      name: 'errorInvalidUrlFormat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get errorInvalidEmailFormat {
    return Intl.message(
      'Invalid email format',
      name: 'errorInvalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get errorMessagePermissionDenied {
    return Intl.message(
      'Access denied',
      name: 'errorMessagePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Permission required`
  String get errorMessagePermissionRequired {
    return Intl.message(
      'Permission required',
      name: 'errorMessagePermissionRequired',
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

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
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

  /// `{hours} h {minutes} min`
  String durationInHoursMinutes(Object hours, Object minutes) {
    return Intl.message(
      '$hours h $minutes min',
      name: 'durationInHoursMinutes',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `{minutes} min`
  String durationInMinutes(Object minutes) {
    return Intl.message(
      '$minutes min',
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
      Locale.fromSubtags(languageCode: 'en'),
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
