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

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `June`
  String get monthJune {
    return Intl.message('June', name: 'monthJune', desc: '', args: []);
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

  /// `June`
  String get montJune {
    return Intl.message('June', name: 'montJune', desc: '', args: []);
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

  /// `Select`
  String get toSelect {
    return Intl.message('Select', name: 'toSelect', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Unexpected error`
  String get errorMessageUnexpectedError {
    return Intl.message(
      'Unexpected error',
      name: 'errorMessageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Check connection and try again`
  String get errorMessageCheckAndTryLater {
    return Intl.message(
      'Check connection and try again',
      name: 'errorMessageCheckAndTryLater',
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
