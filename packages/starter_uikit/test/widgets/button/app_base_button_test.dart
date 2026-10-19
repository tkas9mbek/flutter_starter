import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/button/app_base_button.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  final theme = AppTheme.light();
  final calls = <String>[];

  setUp(calls.clear);

  Widget buildButton({
    bool enabled = true,
    bool loading = false,
    Widget? icon,
    TextDirection iconDirection = TextDirection.ltr,
  }) => AppBaseButton(
    text: 'Pay',
    backgroundColor: theme.primary,
    textColor: theme.onPrimary,
    textStyle: AppTextStyles(theme).mediumBody16,
    height: 48,
    enabled: enabled,
    loading: loading,
    icon: icon,
    iconDirection: iconDirection,
    onPressed: () => calls.add('pressed'),
    onLongPressed: () => calls.add('longPressed'),
    onDisabledPressed: () => calls.add('disabledPressed'),
  );

  group('AppBaseButton', () {
    testWidgets('fires onPressed and onLongPressed while active', (
      tester,
    ) async {
      await tester.pumpApp(buildButton());
      await tester.tap(find.text('Pay'));
      await tester.longPress(find.text('Pay'));

      expect(calls, ['pressed', 'longPressed']);
    });

    testWidgets('disabled routes taps to onDisabledPressed only', (
      tester,
    ) async {
      await tester.pumpApp(buildButton(enabled: false));
      await tester.tap(find.text('Pay'));
      await tester.longPress(find.text('Pay'));

      expect(calls, ['disabledPressed', 'disabledPressed']);
    });

    testWidgets('loading swallows taps without calling onDisabledPressed', (
      tester,
    ) async {
      await tester.pumpApp(buildButton(loading: true), settle: false);
      await tester.tap(find.byType(AppBaseButton));
      await tester.longPress(find.byType(AppBaseButton));

      expect(find.text('Pay'), findsNothing);
      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
      expect(calls, isEmpty);
    });

    testWidgets('places the icon on the side given by iconDirection', (
      tester,
    ) async {
      const icon = SizedBox(key: Key('icon'), width: 16, height: 16);

      await tester.pumpApp(buildButton(icon: icon));

      final ltrRow = tester.widget<Row>(
        find.ancestor(of: find.text('Pay'), matching: find.byType(Row)),
      );

      expect(ltrRow.children.first.key, const Key('icon'));

      await tester.pumpApp(
        buildButton(icon: icon, iconDirection: TextDirection.rtl),
      );

      final rtlRow = tester.widget<Row>(
        find.ancestor(of: find.text('Pay'), matching: find.byType(Row)),
      );

      expect(rtlRow.children.last.key, const Key('icon'));
    });
  });
}
