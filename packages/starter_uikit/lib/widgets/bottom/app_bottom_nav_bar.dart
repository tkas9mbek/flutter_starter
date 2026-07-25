import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Surface-colored bottom navigation bar laying out its [children]
/// (typically [BottomNavItem] widgets, which expand to share the screen
/// width evenly) in a row.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return DecoratedBox(
      decoration: BoxDecoration(color: theme.surface),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: children),
      ),
    );
  }
}
