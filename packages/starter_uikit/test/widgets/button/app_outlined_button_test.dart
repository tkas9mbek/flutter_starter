import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_colors.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/button/app_base_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

import '../../support/pump_app.dart';

void main() {
  Widget buildButton({
    VoidCallback? onPressed,
    bool enabled = true,
    bool loading = false,
  }) => Builder(
    builder: (context) => AppOutlinedButton.big(
      context: context,
      text: 'Go',
      onPressed: onPressed,
      enabled: enabled,
      loading: loading,
    ),
  );

  group('AppOutlinedButton', () {
    testWidgets('fires onPressed on tap and shows its label', (tester) async {
      var taps = 0;

      await tester.pumpApp(buildButton(onPressed: () => taps++));
      await tester.tap(find.text('Go'));

      expect(taps, 1);
      expect(find.byType(CustomCircularProgressIndicator), findsNothing);
    });

    testWidgets('does not fire onPressed when enabled is false', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpApp(
        buildButton(onPressed: () => taps++, enabled: false),
      );
      await tester.tap(find.text('Go'));

      expect(taps, 0);
    });

    testWidgets('loading swaps the label for a progress indicator and '
        'blocks taps', (tester) async {
      var taps = 0;

      await tester.pumpApp(
        buildButton(onPressed: () => taps++, loading: true),
        settle: false,
      );
      await tester.tap(find.byType(ElevatedButton));

      expect(find.text('Go'), findsNothing);
      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
      expect(taps, 0);
    });

    testWidgets('factories set the size step and label style', (tester) async {
      final textStyles = AppTextStyles(AppTheme.light());
      final factories = {
        'big': (
          AppOutlinedButton.big,
          52.0,
          double.infinity,
          textStyles.mediumBody16,
        ),
        'medium': (
          AppOutlinedButton.medium,
          48.0,
          double.infinity,
          textStyles.mediumBody16,
        ),
        'small': (AppOutlinedButton.small, 40.0, null, textStyles.mediumBody14),
      };

      for (final MapEntry(key: name, value: spec) in factories.entries) {
        final (factory, height, width, textStyle) = spec;

        await tester.pumpApp(
          Center(
            child: Builder(
              builder: (context) =>
                  factory(context: context, text: name, onPressed: () {}),
            ),
          ),
        );

        final base = tester.widget<AppBaseButton>(find.byType(AppBaseButton));

        expect(base.height, height, reason: name);
        expect(base.width, width, reason: name);
        expect(base.textStyle, textStyle, reason: name);
      }
    });

    testWidgets('draws an accent outline that turns to border when disabled', (
      tester,
    ) async {
      final theme = AppTheme.light();

      await tester.pumpApp(buildButton(onPressed: () {}));

      final base = tester.widget<AppBaseButton>(find.byType(AppBaseButton));

      expect(base.backgroundColor, AppColors.transparent);
      expect(base.borderColor, theme.accent);
      expect(base.textColor, theme.accent);
      expect(base.disabledBorderColor, theme.border);
      expect(base.disabledTextColor, theme.textTertiary);
    });

    testWidgets('borderColor and textColor override the accent', (
      tester,
    ) async {
      final theme = AppTheme.light();

      await tester.pumpApp(
        AppOutlinedButton(
          text: 'Delete',
          textStyle: AppTextStyles(theme).mediumBody16,
          borderColor: theme.errorText,
          textColor: theme.errorText,
          onPressed: () {},
        ),
      );

      final base = tester.widget<AppBaseButton>(find.byType(AppBaseButton));
      final label = tester.widget<Text>(find.text('Delete'));

      expect(base.borderColor, theme.errorText);
      expect(label.style!.color, theme.errorText);
    });
  });
}
