import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/misc/network_image_avatar.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class MiscWidgetsExampleScreen extends StatelessWidget {
  const MiscWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(title: localizer.miscWidgets),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizer.networkAvatar,
              style: textStyles.mediumBody16,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                NetworkImageAvatar(
                  imageUrl: 'https://i.pravatar.cc/150?img=1',
                  size: 60,
                ),
                SizedBox(width: 16),
                NetworkImageAvatar(
                  imageUrl: 'https://i.pravatar.cc/150?img=2',
                  size: 80,
                ),
                SizedBox(width: 16),
                NetworkImageAvatar(
                  imageUrl: 'https://i.pravatar.cc/150?img=3',
                  size: 100,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              localizer.thinDivider,
              style: textStyles.mediumBody16,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text('Item 1', style: textStyles.regularBody14),
                  const ThinHorizontalDivider(),
                  Text('Item 2', style: textStyles.regularBody14),
                  const ThinHorizontalDivider(),
                  Text('Item 3', style: textStyles.regularBody14),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.progressIndicator,
              style: textStyles.mediumBody16,
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 100,
              child: Center(
                child: CustomCircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
