import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/example/widgets/example_section.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/text/auto_formatted_text.dart';
import 'package:starter_uikit/widgets/text/bulleted_text_list.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class TextWidgetsExampleScreen extends StatelessWidget {
  const TextWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(title: localizer.textWidgets),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ExampleSection(
              title: 'Title and subtitle',
              children: [
                TitleSubtitle(
                  title: 'Verify your number',
                  subtitle: 'We sent a 4-digit code to +996 555 123 456',
                ),
                TitleSubtitle(
                  title: 'Start-aligned heading',
                  subtitle: 'Used above forms and long content',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            ExampleSection(
              title: localizer.autoFormattedText,
              children: [
                AutoFormattedText(
                  'This is *bold* text and *these words* are bold too.',
                  tag: '*',
                  formatStyle: textStyles.boldBody14,
                ),
                AutoFormattedText(
                  'Visit our website at _example.com_ or '
                  'call us at _+7 (999) 123-45-67_',
                  tag: '_',
                  style: textStyles.regularBody14.copyWith(
                    color: theme.textSecondary,
                  ),
                  formatStyle: textStyles.mediumBody14.copyWith(
                    color: theme.accent,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.accent,
                  ),
                ),
              ],
            ),
            ExampleSection(
              title: localizer.bulletedList,
              children: const [
                BulletedTextList(
                  texts: [
                    'First item in the list',
                    'Second item with more content',
                    'Third item is here',
                    'Fourth and final item',
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
