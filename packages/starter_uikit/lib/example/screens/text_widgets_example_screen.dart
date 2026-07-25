import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/text/auto_formatted_text.dart';
import 'package:starter_uikit/widgets/text/bulleted_text_list.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class TextWidgetsExampleScreen extends StatelessWidget {
  const TextWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.textWidgets),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizer.autoFormattedText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const AutoFormattedText(
              'This is *bold* text and *these words* are bold too.',
              tag: '*',
              formatStyle: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.bulletedList,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const BulletedTextList(
              texts: [
                'First item in the list',
                'Second item with more content',
                'Third item is here',
                'Fourth and final item',
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Custom styled text:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const AutoFormattedText(
              'Visit our website at _example.com_ or '
              'call us at _+7 (999) 123-45-67_',
              tag: '_',
              style: TextStyle(fontSize: 14),
              formatStyle: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
