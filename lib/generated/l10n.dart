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

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
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

  /// `For example, +1 (123) 456-78-90`
  String get errorInvalidPhoneFormat {
    return Intl.message(
      'For example, +1 (123) 456-78-90',
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

  /// `Refresh`
  String get retry {
    return Intl.message('Refresh', name: 'retry', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Incorrect code`
  String get incorrectCode {
    return Intl.message(
      'Incorrect code',
      name: 'incorrectCode',
      desc: '',
      args: [],
    );
  }

  /// `Code from SMS`
  String get codeFromSms {
    return Intl.message(
      'Code from SMS',
      name: 'codeFromSms',
      desc: '',
      args: [],
    );
  }

  /// `By logging in or registering, you agree to`
  String get youAgreeWhenLogin {
    return Intl.message(
      'By logging in or registering, you agree to',
      name: 'youAgreeWhenLogin',
      desc: '',
      args: [],
    );
  }

  /// `the`
  String get withThe {
    return Intl.message('the', name: 'withThe', desc: '', args: []);
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

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
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

  /// `Resend code`
  String get sendAgain {
    return Intl.message('Resend code', name: 'sendAgain', desc: '', args: []);
  }

  /// `You can request a new code in {time}`
  String newOptAfterSeconds(Object time) {
    return Intl.message(
      'You can request a new code in $time',
      name: 'newOptAfterSeconds',
      desc: '',
      args: [time],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `June`
  String get montJune {
    return Intl.message('June', name: 'montJune', desc: '', args: []);
  }

  /// `April`
  String get monthApril {
    return Intl.message('April', name: 'monthApril', desc: '', args: []);
  }

  /// `August`
  String get monthAugust {
    return Intl.message('August', name: 'monthAugust', desc: '', args: []);
  }

  /// `December`
  String get monthDecember {
    return Intl.message('December', name: 'monthDecember', desc: '', args: []);
  }

  /// `February`
  String get monthFebruary {
    return Intl.message('February', name: 'monthFebruary', desc: '', args: []);
  }

  /// `January`
  String get monthJanuary {
    return Intl.message('January', name: 'monthJanuary', desc: '', args: []);
  }

  /// `July`
  String get monthJuly {
    return Intl.message('July', name: 'monthJuly', desc: '', args: []);
  }

  /// `March`
  String get monthMarch {
    return Intl.message('March', name: 'monthMarch', desc: '', args: []);
  }

  /// `May`
  String get monthMay {
    return Intl.message('May', name: 'monthMay', desc: '', args: []);
  }

  /// `November`
  String get monthNovember {
    return Intl.message('November', name: 'monthNovember', desc: '', args: []);
  }

  /// `October`
  String get monthOctober {
    return Intl.message('October', name: 'monthOctober', desc: '', args: []);
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

  /// `No connection`
  String get errorMessageNoInternetConnection {
    return Intl.message(
      'No connection',
      name: 'errorMessageNoInternetConnection',
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

  /// `Something went wrong`
  String get errorMessageUnexpectedError {
    return Intl.message(
      'Something went wrong',
      name: 'errorMessageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Cancel`
  String get toCancel {
    return Intl.message('Cancel', name: 'toCancel', desc: '', args: []);
  }

  /// `Select date`
  String get selectDate {
    return Intl.message('Select date', name: 'selectDate', desc: '', args: []);
  }

  /// `Next`
  String get goNext {
    return Intl.message('Next', name: 'goNext', desc: '', args: []);
  }

  /// `Copied`
  String get copied {
    return Intl.message('Copied', name: 'copied', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Cancellation`
  String get cancellation {
    return Intl.message(
      'Cancellation',
      name: 'cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Check your network connection and refresh the page`
  String get tryRefreshPage {
    return Intl.message(
      'Check your network connection and refresh the page',
      name: 'tryRefreshPage',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get errorMessageAuthRequired {
    return Intl.message(
      'Please login to continue',
      name: 'errorMessageAuthRequired',
      desc: '',
      args: [],
    );
  }

  /// `You do not have the rights to view this page.`
  String get errorMessageNoRightsToView {
    return Intl.message(
      'You do not have the rights to view this page.',
      name: 'errorMessageNoRightsToView',
      desc: '',
      args: [],
    );
  }

  /// `You do not have the rights to perform this action.`
  String get errorMessageNoRightsToPerform {
    return Intl.message(
      'You do not have the rights to perform this action.',
      name: 'errorMessageNoRightsToPerform',
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
