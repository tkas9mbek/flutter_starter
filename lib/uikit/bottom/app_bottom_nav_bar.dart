import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/bottom/bottom_nav_item.dart';

class RootBottomNavBar extends StatelessWidget {
  /// Bottom navigation bar with rounded corners, white background, small elevation
  /// and shadow.
  /// The children are evenly distributed across the width of the screen.
  /// * [children] is a list of [BottomNavItem] widgets.
  const RootBottomNavBar({
    required this.children,
    super.key,
  });

  final List<BottomNavItem> children;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: children.map((e) => Expanded(child: e)).toList(),
      ),
    );
  }
}
