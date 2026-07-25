import 'package:flutter/material.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Flat 40x40 surface-colored rounded back button that pops the current
/// route by default, or invokes [onTap] when provided.
class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: SvgIcon(
            UiSvgIcons.chevronLeft,
            size: 24,
            color: theme.textPrimary,
          ),
        ),
      ),
    );
  }
}
