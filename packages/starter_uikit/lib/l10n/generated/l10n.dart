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

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get monthJune {
    return Intl.message(
      'June',
      name: 'monthJune',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get monthApril {
    return Intl.message(
      'April',
      name: 'monthApril',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get monthAugust {
    return Intl.message(
      'August',
      name: 'monthAugust',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get monthDecember {
    return Intl.message(
      'December',
      name: 'monthDecember',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get monthFebruary {
    return Intl.message(
      'February',
      name: 'monthFebruary',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get monthJanuary {
    return Intl.message(
      'January',
      name: 'monthJanuary',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get montJune {
    return Intl.message(
      'June',
      name: 'montJune',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get monthJuly {
    return Intl.message(
      'July',
      name: 'monthJuly',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get monthMarch {
    return Intl.message(
      'March',
      name: 'monthMarch',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get monthMay {
    return Intl.message(
      'May',
      name: 'monthMay',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get monthNovember {
    return Intl.message(
      'November',
      name: 'monthNovember',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get monthOctober {
    return Intl.message(
      'October',
      name: 'monthOctober',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get monthSeptember {
    return Intl.message(
      'September',
      name: 'monthSeptember',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get toSelect {
    return Intl.message(
      'Select',
      name: 'toSelect',
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

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancellation {
    return Intl.message(
      'Cancel',
      name: 'cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
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

  /// `Try refreshing the page`
  String get tryRefreshPage {
    return Intl.message(
      'Try refreshing the page',
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
      Locale.fromSubtags(languageCode: 'en'),
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
