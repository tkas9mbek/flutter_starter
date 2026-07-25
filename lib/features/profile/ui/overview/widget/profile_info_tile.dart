import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  /// Asset path from `UiSvgIcons`.
  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgIcon(icon, size: 24, color: theme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textStyles.regularBody13.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: textStyles.mediumBody14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
