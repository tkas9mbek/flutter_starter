import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  final chevron = find.byWidgetPredicate(
    (widget) => widget is SvgIcon && widget.icon == UiSvgIcons.chevronRight,
  );
  final spinner = find.byType(CustomCircularProgressIndicator);

  group('AppListTile', () {
    testWidgets('shows title, subtitle and value', (tester) async {
      await tester.pumpApp(
        const AppListTile(
          icon: UiSvgIcons.globeLanguage,
          title: 'Language',
          subtitle: 'App language',
          value: 'English',
        ),
      );

      expect(find.text('Language'), findsOneWidget);
      expect(find.text('App language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('a tappable row fires onTap and ends in a chevron', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpApp(AppListTile(title: 'Row', onTap: () => taps++));
      await tester.tap(find.text('Row'));

      expect(taps, 1);
      expect(chevron, findsOneWidget);
    });

    testWidgets('a row without onTap has no chevron', (tester) async {
      await tester.pumpApp(const AppListTile(title: 'Row'));
      await tester.tap(find.text('Row'));

      expect(chevron, findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading shows a spinner instead of the chevron and ignores '
        'taps', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        AppListTile(title: 'Row', loading: true, onTap: () => taps++),
        settle: false,
      );
      await tester.tap(find.text('Row'));

      expect(spinner, findsOneWidget);
      expect(chevron, findsNothing);
      expect(taps, 0);
    });

    testWidgets('danger row fires onTap, has no chevron and uses the error '
        'text color', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        AppListTile(title: 'Delete', danger: true, onTap: () => taps++),
      );
      await tester.tap(find.text('Delete'));

      final theme = ThemeProvider.of(tester.element(find.text('Delete'))).theme;

      expect(taps, 1);
      expect(chevron, findsNothing);
      expect(
        tester.widget<Text>(find.text('Delete')).style?.color,
        theme.errorText,
      );
    });

    testWidgets('a custom trailing replaces the chevron', (tester) async {
      await tester.pumpApp(
        AppListTile(
          title: 'Row',
          trailing: const Text('Trailing'),
          onTap: () {},
        ),
      );

      expect(find.text('Trailing'), findsOneWidget);
      expect(chevron, findsNothing);
    });
  });
}
