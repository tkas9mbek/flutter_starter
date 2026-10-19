import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Wraps [child] with `ThemeProvider` > `MaterialApp` (as the app does, so
/// overlay entries can read the theme), the uikit/toolkit localization
/// delegates, and a `Scaffold` so leaf widgets have a Material ancestor.
Widget wrapApp(Widget child) => ThemeProvider(
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      UikitLocalizer.delegate,
      ToolkitLocalizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: UikitLocalizer.delegate.supportedLocales,
    home: Scaffold(body: child),
  ),
);

extension PumpAppX on WidgetTester {
  /// Pumps [child] wrapped by [wrapApp].
  ///
  /// Pass `settle: false` for widgets with endless animations (spinners),
  /// where `pumpAndSettle` would never return.
  Future<void> pumpApp(Widget child, {bool settle = true}) async {
    await pumpWidget(wrapApp(child));

    if (settle) {
      await pumpAndSettle();
    } else {
      await pump(const Duration(milliseconds: 100));
    }
  }

  /// Opacity of the nearest [AnimatedOpacity] above [finder].
  ///
  /// `AnimatedVisibility` keeps hidden content in the tree at opacity 0, so
  /// "is the error shown" means opacity 1, not `findsOneWidget`.
  double fadeOpacityOf(Finder finder) => widget<AnimatedOpacity>(
    find.ancestor(of: finder, matching: find.byType(AnimatedOpacity)).first,
  ).opacity;

  /// Uikit localizations resolved below the `MaterialApp`.
  UikitLocalizer get uikitL10n =>
      UikitLocalizer.of(element(find.byType(Scaffold)));

  /// Toolkit localizations resolved below the `MaterialApp`.
  ToolkitLocalizer get toolkitL10n =>
      ToolkitLocalizer.of(element(find.byType(Scaffold)));
}
