import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/misc/safe_vertical_box.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.iconPath,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.package,
    super.key,
  });

  final String iconPath;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final String? package;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final color = isActive ? theme.primary : theme.textPrimary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset(
            iconPath,
            package: package,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: textStyles.regularBody13.copyWith(
              color: color,
            ),
          ),
          const SafeVerticalBox(
            height: 10,
            bottom: true,
          ),
        ],
      ),
    );
  }
}
