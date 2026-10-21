import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/bottom/app_bottom_nav_bar.dart';
import 'package:starter_uikit/widgets/bottom/bottom_nav_item.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildBar({required int active, required ValueChanged<int> onTap}) =>
      AppBottomNavBar(
        children: [
          for (final (index, title) in ['Home', 'Profile'].indexed) ...[
            BottomNavItem(
              iconPath: UiSvgIcons.personProfile,
              package: UiConsts.package,
              title: title,
              isActive: index == active,
              onTap: () => onTap(index),
            ),
          ],
        ],
      );

  Color? colorOf(WidgetTester tester, String title) =>
      tester.widget<Text>(find.text(title)).style?.color;

  group('AppBottomNavBar / BottomNavItem', () {
    testWidgets('shows every title and reports the tapped item', (
      tester,
    ) async {
      final tapped = <int>[];

      await tester.pumpApp(buildBar(active: 0, onTap: tapped.add));
      await tester.tap(find.text('Profile'));

      expect(find.text('Home'), findsOneWidget);
      expect(tapped, [1]);
    });

    testWidgets('tints the active item accent and the rest tertiary', (
      tester,
    ) async {
      await tester.pumpApp(buildBar(active: 1, onTap: (_) {}));

      final theme = ThemeProvider.of(tester.element(find.text('Home'))).theme;

      expect(colorOf(tester, 'Profile'), theme.accent);
      expect(colorOf(tester, 'Home'), theme.textTertiary);
    });

    testWidgets('keeps labels on one line at an accessibility text size', (
      tester,
    ) async {
      await tester.pumpApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(3)),
          child: buildBar(active: 0, onTap: (_) {}),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.text('Profile')).height, lessThan(30));
    });
  });
}
