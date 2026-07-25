import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Wraps a screen for widget smoke tests: `MaterialApp` + the three app
/// localization delegates + `ThemeProvider`.
///
/// Pump it, then `await tester.pumpAndSettle()` to let localization load, then
/// `expect(tester.takeException(), isNull)`.
Widget wrapApp(Widget child) => MaterialApp(
  locale: const Locale('ru'),
  localizationsDelegates: const [
    Localizer.delegate,
    UikitLocalizer.delegate,
    ToolkitLocalizer.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: Localizer.delegate.supportedLocales,
  home: ThemeProvider(child: child),
);

/// Like [wrapApp] but also gives the widget a `Scaffold` ancestor — use for
/// leaf widgets (cards, tiles) that aren't full screens.
Widget wrapWidget(Widget child) => wrapApp(Scaffold(body: child));
