import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Flat app bar on the theme surface color with no elevation or shadow,
/// sized to [height] and hosting an arbitrary [child] as its title area.
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    required this.height,
    required this.child,
    this.bottom,
    super.key,
  });

  final double height;
  final Widget child;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AppBar(
      backgroundColor: theme.surface,
      surfaceTintColor: theme.surface,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: SizedBox(height: height, child: child),
      bottom: bottom,
    );
  }
}
