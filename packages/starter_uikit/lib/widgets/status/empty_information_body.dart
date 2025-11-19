import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

/// A widget that displays empty state with icon, text, and optional retry button.
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
            if (iconPath != null)
              SvgPicture.asset(
                iconPath!,
                package: UiConsts.package,
                width: 64,
                height: 64,
                colorFilter: ColorFilter.mode(
                  theme.textSecondary,
                  BlendMode.srcIn,
                ),
              )
            else
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: theme.textSecondary,
              ),
            const SizedBox(height: 16),
            Text(
              text ?? UiLocalizer.of(context).noDataAvailable,
              style: textStyles.regularBody14.copyWith(
                color: theme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              AppOutlinedButton.medium(
                context: context,
                text: UiLocalizer.of(context).retry,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
