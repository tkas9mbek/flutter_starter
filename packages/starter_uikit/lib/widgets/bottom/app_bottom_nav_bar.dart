import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Flat surface-colored bottom navigation bar, separated from the page by a
/// top hairline, laying out its [children] (typically [BottomNavItem]
/// widgets, which expand to share the width evenly) in a row.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border(top: BorderSide(color: theme.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: children),
      ),
    );
  }
}
