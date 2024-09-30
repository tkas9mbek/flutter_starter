import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/divider/thin_vertical_divider.dart';

class RoundedTabBar extends StatelessWidget {
  static const double radius = 24;

  const RoundedTabBar({
    required this.tabs,
    this.activeIndex = 0,
    this.height,
    this.onTap,
    super.key,
  });

  final List<Widget> tabs;
  final Function(int)? onTap;
  final int activeIndex;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(radius),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.06),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++) ...[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onTap?.call(i),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                  decoration: BoxDecoration(
                    color:
                        activeIndex == i ? theme.primary : Colors.transparent,
                  ),
                  child: Center(child: tabs[i]),
                ),
              ),
            ),
            if (i != tabs.length - 1) ...[
              const ThinVerticalDivider(),
            ],
          ],
        ],
      ),
    );
  }
}
