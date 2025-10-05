import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';


class AppBottomNavBar extends StatelessWidget {
  /// Bottom navigation bar with rounded corners, white background, small elevation
  /// and shadow.
  /// The children are evenly distributed across the width of the screen.
  /// * [children] is a list of [BottomNavItem] widgets.
  const AppBottomNavBar({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: children.map((e) => Expanded(child: e)).toList(),
        ),
      ),
    );
  }
}
