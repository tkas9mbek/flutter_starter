import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
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

extension PumpScreenX on WidgetTester {
  /// Pumps [child] with a tall viewport so the whole screen is on screen and
  /// tappable without scrolling. The viewport resets when the test ends.
  Future<void> pumpTall(Widget child) async {
    view
      ..physicalSize = const Size(800, 2000)
      ..devicePixelRatio = 1;
    addTearDown(view.reset);

    await pumpWidget(child);
    await pumpAndSettle();
  }

  /// Every `Text` in the first scroll view, in order: what the user reads.
  /// Compare two lists to prove two implementations render the same screen.
  List<String> visibleTexts() => widgetList<Text>(
    find.descendant(
      of: find.byType(SingleChildScrollView).first,
      matching: find.byType(Text),
    ),
  ).map((text) => text.data ?? '').toList();
}
