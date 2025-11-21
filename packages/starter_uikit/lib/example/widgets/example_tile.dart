import 'package:flutter/material.dart';

/// **INTERNAL USE ONLY**: A reusable tile widget for UIKit examples.
///
/// Displays a list tile with an icon, title, subtitle, and trailing arrow.
/// Used throughout the UIKit example screens for consistent navigation.
@visibleForTesting
class ExampleTile extends StatelessWidget {
  const ExampleTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon ?? Icons.arrow_forward,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
