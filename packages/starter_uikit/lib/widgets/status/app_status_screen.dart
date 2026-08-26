import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';

/// Full-screen terminal outcome (success, error, or similar one-shot result):
/// an icon circle, a title/subtitle, and a primary action with an optional
/// secondary action.
///
/// Every piece of content is injected via the constructor — icon, copy,
/// button labels, and callbacks. This widget never reaches for a
/// `Localizer`, `getIt`, `AppRouter`, or any BLoC internally, so it can
/// render standalone even when app-level DI or routing has failed to
/// initialize.
class AppStatusScreen extends StatelessWidget {
  const AppStatusScreen({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
    this.secondaryButtonLabel,
    this.onSecondaryPressed,
    super.key,
  });

  /// Already-built icon widget (e.g. an `SvgIcon`), centered in a fixed
  /// 120px circle.
  final Widget icon;

  /// Already-localized copy — this widget never looks up a `Localizer`.
  final String title;

  /// Already-localized copy — this widget never looks up a `Localizer`.
  final String subtitle;

  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;

  final String? secondaryButtonLabel;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return ColoredBox(
      color: theme.background,
      child: Column(
        children: [
          const SafeVerticalBox(top: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.surfaceMuted,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    style: textStyles.boldTitle20,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: textStyles.regularBody14.copyWith(
                      color: theme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  AppElevatedButton.big(
                    context: context,
                    text: primaryButtonLabel,
                    onPressed: onPrimaryPressed,
                  ),
                  if (secondaryButtonLabel != null) ...[
                    const SizedBox(height: 12),
                    AppOutlinedButton.big(
                      context: context,
                      text: secondaryButtonLabel!,
                      onPressed: onSecondaryPressed,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SafeVerticalBox(bottom: true, height: 16),
        ],
      ),
    );
  }
}
