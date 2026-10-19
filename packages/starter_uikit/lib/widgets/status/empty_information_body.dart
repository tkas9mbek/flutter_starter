import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Centered empty state: a muted icon, a message (localized "no data" by
/// default) and an optional outlined retry button.
class EmptyInformationBody extends StatelessWidget {
  const EmptyInformationBody({
    this.iconPath,
    this.text,
    this.onRetry,
    super.key,
  });

  final String? iconPath;
  final String? text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              iconPath ?? UiSvgIcons.inboxTray,
              size: 56,
              color: theme.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              text ?? UikitLocalizer.of(context).noDataAvailable,
              style: textStyles.regularBody16.copyWith(
                color: theme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              AppOutlinedButton.medium(
                context: context,
                text: UikitLocalizer.of(context).retry,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
