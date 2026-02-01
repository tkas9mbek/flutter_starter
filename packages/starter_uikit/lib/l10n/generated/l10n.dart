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

class UikitLocalizer {
  UikitLocalizer();

  static UikitLocalizer? _current;

  static UikitLocalizer get current {
    assert(_current != null,
        'No instance of UikitLocalizer was loaded. Try to initialize the UikitLocalizer delegate before accessing UikitLocalizer.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<UikitLocalizer> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = UikitLocalizer();
      UikitLocalizer._current = instance;

      return instance;
    });
  }

  static UikitLocalizer of(BuildContext context) {
    final instance = UikitLocalizer.maybeOf(context);
    assert(instance != null,
        'No instance of UikitLocalizer present in the widget tree. Did you add UikitLocalizer.delegate in localizationsDelegates?');
    return instance!;
  }

  static UikitLocalizer? maybeOf(BuildContext context) {
    return Localizations.of<UikitLocalizer>(context, UikitLocalizer);
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

  /// `UI Kit`
  String get uiKit {
    return Intl.message(
      'UI Kit',
      name: 'uiKit',
      desc: '',
      args: [],
    );
  }

  /// `UI Kit Component Examples`
  String get uiKitExamples {
    return Intl.message(
      'UI Kit Component Examples',
      name: 'uiKitExamples',
      desc: '',
      args: [],
    );
  }

  /// `Buttons`
  String get buttons {
    return Intl.message(
      'Buttons',
      name: 'buttons',
      desc: '',
      args: [],
    );
  }

  /// `Elevated and outlined buttons with loading states`
  String get buttonsDescription {
    return Intl.message(
      'Elevated and outlined buttons with loading states',
      name: 'buttonsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Form Fields`
  String get formFields {
    return Intl.message(
      'Form Fields',
      name: 'formFields',
      desc: '',
      args: [],
    );
  }

  /// `Text fields, dropdowns, date pickers`
  String get formFieldsDescription {
    return Intl.message(
      'Text fields, dropdowns, date pickers',
      name: 'formFieldsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Status Widgets`
  String get statusWidgets {
    return Intl.message(
      'Status Widgets',
      name: 'statusWidgets',
      desc: '',
      args: [],
    );
  }

  /// `Loading, empty data, and error states`
  String get statusWidgetsDescription {
    return Intl.message(
      'Loading, empty data, and error states',
      name: 'statusWidgetsDescription',
      desc: '',
      args: [],
    );
  }

  /// `App Bars`
  String get appBars {
    return Intl.message(
      'App Bars',
      name: 'appBars',
      desc: '',
      args: [],
    );
  }

  /// `Title and base app bars`
  String get appBarsDescription {
    return Intl.message(
      'Title and base app bars',
      name: 'appBarsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Dialogs`
  String get dialogs {
    return Intl.message(
      'Dialogs',
      name: 'dialogs',
      desc: '',
      args: [],
    );
  }

  /// `Bottom sheets, date pickers, confirmations`
  String get dialogsDescription {
    return Intl.message(
      'Bottom sheets, date pickers, confirmations',
      name: 'dialogsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Text Widgets`
  String get textWidgets {
    return Intl.message(
      'Text Widgets',
      name: 'textWidgets',
      desc: '',
      args: [],
    );
  }

  /// `Auto-formatting and bulleted lists`
  String get textWidgetsDescription {
    return Intl.message(
      'Auto-formatting and bulleted lists',
      name: 'textWidgetsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous`
  String get miscWidgets {
    return Intl.message(
      'Miscellaneous',
      name: 'miscWidgets',
      desc: '',
      args: [],
    );
  }

  /// `Avatars, dividers, progress indicators`
  String get miscWidgetsDescription {
    return Intl.message(
      'Avatars, dividers, progress indicators',
      name: 'miscWidgetsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Elevated Button`
  String get elevatedButton {
    return Intl.message(
      'Elevated Button',
      name: 'elevatedButton',
      desc: '',
      args: [],
    );
  }

  /// `Outlined Button`
  String get outlinedButton {
    return Intl.message(
      'Outlined Button',
      name: 'outlinedButton',
      desc: '',
      args: [],
    );
  }

  /// `Disabled Button`
  String get disabledButton {
    return Intl.message(
      'Disabled Button',
      name: 'disabledButton',
      desc: '',
      args: [],
    );
  }

  /// `Loading Button`
  String get loadingButton {
    return Intl.message(
      'Loading Button',
      name: 'loadingButton',
      desc: '',
      args: [],
    );
  }

  /// `Button pressed!`
  String get buttonPressed {
    return Intl.message(
      'Button pressed!',
      name: 'buttonPressed',
      desc: '',
      args: [],
    );
  }

  /// `Text Field`
  String get textField {
    return Intl.message(
      'Text Field',
      name: 'textField',
      desc: '',
      args: [],
    );
  }

  /// `Enter text`
  String get enterText {
    return Intl.message(
      'Enter text',
      name: 'enterText',
      desc: '',
      args: [],
    );
  }

  /// `Dropdown Field`
  String get dropdownField {
    return Intl.message(
      'Dropdown Field',
      name: 'dropdownField',
      desc: '',
      args: [],
    );
  }

  /// `Select option`
  String get selectOption {
    return Intl.message(
      'Select option',
      name: 'selectOption',
      desc: '',
      args: [],
    );
  }

  /// `Option 1`
  String get option1 {
    return Intl.message(
      'Option 1',
      name: 'option1',
      desc: '',
      args: [],
    );
  }

  /// `Option 2`
  String get option2 {
    return Intl.message(
      'Option 2',
      name: 'option2',
      desc: '',
      args: [],
    );
  }

  /// `Option 3`
  String get option3 {
    return Intl.message(
      'Option 3',
      name: 'option3',
      desc: '',
      args: [],
    );
  }

  /// `Date Picker`
  String get datePickerField {
    return Intl.message(
      'Date Picker',
      name: 'datePickerField',
      desc: '',
      args: [],
    );
  }

  /// `Checkbox`
  String get checkboxField {
    return Intl.message(
      'Checkbox',
      name: 'checkboxField',
      desc: '',
      args: [],
    );
  }

  /// `Agree to terms`
  String get agreeToTerms {
    return Intl.message(
      'Agree to terms',
      name: 'agreeToTerms',
      desc: '',
      args: [],
    );
  }

  /// `Loading State`
  String get loadingState {
    return Intl.message(
      'Loading State',
      name: 'loadingState',
      desc: '',
      args: [],
    );
  }

  /// `Empty State`
  String get emptyState {
    return Intl.message(
      'Empty State',
      name: 'emptyState',
      desc: '',
      args: [],
    );
  }

  /// `Failure State`
  String get failureState {
    return Intl.message(
      'Failure State',
      name: 'failureState',
      desc: '',
      args: [],
    );
  }

  /// `Title App Bar`
  String get titleAppBar {
    return Intl.message(
      'Title App Bar',
      name: 'titleAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Base App Bar`
  String get baseAppBar {
    return Intl.message(
      'Base App Bar',
      name: 'baseAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Transparent App Bar`
  String get transparentAppBar {
    return Intl.message(
      'Transparent App Bar',
      name: 'transparentAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Custom Title`
  String get customTitle {
    return Intl.message(
      'Custom Title',
      name: 'customTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date Time Picker`
  String get dateTimePicker {
    return Intl.message(
      'Date Time Picker',
      name: 'dateTimePicker',
      desc: '',
      args: [],
    );
  }

  /// `Date Range Picker`
  String get dateRangePicker {
    return Intl.message(
      'Date Range Picker',
      name: 'dateRangePicker',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation Dialog`
  String get confirmationDialog {
    return Intl.message(
      'Confirmation Dialog',
      name: 'confirmationDialog',
      desc: '',
      args: [],
    );
  }

  /// `Dropdown Bottom Sheet`
  String get dropdownBottomSheet {
    return Intl.message(
      'Dropdown Bottom Sheet',
      name: 'dropdownBottomSheet',
      desc: '',
      args: [],
    );
  }

  /// `Show Dialog`
  String get showDialog {
    return Intl.message(
      'Show Dialog',
      name: 'showDialog',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Action`
  String get confirmAction {
    return Intl.message(
      'Confirm Action',
      name: 'confirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
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

  /// `Auto-formatted Text`
  String get autoFormattedText {
    return Intl.message(
      'Auto-formatted Text',
      name: 'autoFormattedText',
      desc: '',
      args: [],
    );
  }

  /// `Bulleted List`
  String get bulletedList {
    return Intl.message(
      'Bulleted List',
      name: 'bulletedList',
      desc: '',
      args: [],
    );
  }

  /// `Network Avatar`
  String get networkAvatar {
    return Intl.message(
      'Network Avatar',
      name: 'networkAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Thin Divider`
  String get thinDivider {
    return Intl.message(
      'Thin Divider',
      name: 'thinDivider',
      desc: '',
      args: [],
    );
  }

  /// `Progress Indicator`
  String get progressIndicator {
    return Intl.message(
      'Progress Indicator',
      name: 'progressIndicator',
      desc: '',
      args: [],
    );
  }

  /// `About UI Kit`
  String get aboutUIKit {
    return Intl.message(
      'About UI Kit',
      name: 'aboutUIKit',
      desc: '',
      args: [],
    );
  }

  /// `This UIKit package contains reusable widgets and components:\n\n• Custom app bars\n• Styled buttons with loading states\n• Form fields with validation\n• Status widgets for different scenarios\n• Notifications via snackbar\n• Theme system support\n\nUse these examples as a reference when building production features.`
  String get uiKitDescription {
    return Intl.message(
      'This UIKit package contains reusable widgets and components:\n\n• Custom app bars\n• Styled buttons with loading states\n• Form fields with validation\n• Status widgets for different scenarios\n• Notifications via snackbar\n• Theme system support\n\nUse these examples as a reference when building production features.',
      name: 'uiKitDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<UikitLocalizer> {
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
  Future<UikitLocalizer> load(Locale locale) => UikitLocalizer.load(locale);
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
