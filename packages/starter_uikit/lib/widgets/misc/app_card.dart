import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';

/// Flat rounded surface separated from the background by a hairline border,
/// tappable when [onTap] is set. [selected] tints the surface and outlines it
/// in the accent color — for picker rows.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.selected = false,
    this.padding,
    this.onTap,
    super.key,
  });

  final Widget child;
  final bool selected;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final borderRadius = BorderRadius.circular(AppRadii.md);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected ? theme.selectedSurface : theme.surface,
        borderRadius: borderRadius,
        border: Border.all(color: selected ? theme.accent : theme.border),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: AppTapArea(
          onTap: onTap,
          selected: onTap == null ? null : selected,
          child: padding == null
              ? child
              : Padding(padding: padding!, child: child),
        ),
      ),
    );
  }
}
