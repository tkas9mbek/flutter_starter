import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

import '../../support/pump_app.dart';

void main() {
  final theme = AppTheme.light();
  final textStyles = AppTextStyles(theme);

  group('TitleSubtitle', () {
    testWidgets('shows the title over a secondary-colored subtitle', (
      tester,
    ) async {
      await tester.pumpApp(
        const TitleSubtitle(title: 'Welcome', subtitle: 'Sign in to go on'),
      );

      final title = tester.widget<Text>(find.text('Welcome'));
      final subtitle = tester.widget<Text>(find.text('Sign in to go on'));

      expect(title.style, textStyles.mediumTitle24);
      expect(subtitle.style!.color, theme.textSecondary);
      expect(title.textAlign, TextAlign.center);
    });

    testWidgets('omits the subtitle when it is null', (tester) async {
      await tester.pumpApp(const TitleSubtitle(title: 'Welcome'));

      expect(
        find.descendant(
          of: find.byType(TitleSubtitle),
          matching: find.byType(Text),
        ),
        findsOneWidget,
      );
    });

    testWidgets('applies custom styles and alignment to both lines', (
      tester,
    ) async {
      await tester.pumpApp(
        TitleSubtitle(
          title: 'Welcome',
          subtitle: 'Sign in',
          textAlign: TextAlign.start,
          titleStyle: textStyles.boldTitle20,
          subtitleStyle: textStyles.regularBody12,
        ),
      );

      final title = tester.widget<Text>(find.text('Welcome'));
      final subtitle = tester.widget<Text>(find.text('Sign in'));

      expect(title.style, textStyles.boldTitle20);
      expect(subtitle.style, textStyles.regularBody12);
      expect(subtitle.textAlign, TextAlign.start);
    });
  });
}
