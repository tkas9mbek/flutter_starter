import 'package:flutter/material.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

/// Flat back chevron with a 40x40 tap area and no fill, so it sits on the
/// app bar's background. Pops the current route by default, or invokes
/// [onTap] when provided.
class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () => Navigator.pop(context),
      child: SizedBox.square(
        dimension: 40,
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
