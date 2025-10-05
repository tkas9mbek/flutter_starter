import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Base app bar bottom rounded corners, with white background,
  /// small elevation and shadow.
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
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return AppBar(
      backgroundColor: theme.surface,
      surfaceTintColor: theme.surface,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 2,
      centerTitle: false,
      shadowColor: theme.background.withValues(alpha: 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      title: SizedBox(
        height: height,
        child: child,
      ),
      bottom: bottom,
    );
  }
}
