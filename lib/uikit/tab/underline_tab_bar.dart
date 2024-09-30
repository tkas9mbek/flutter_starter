import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class UnderlineTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final TabController? controller;
  final Function(int)? onTap;
  final bool isScrollable;
  final TabBarIndicatorSize indicatorSize;
  final Color indicatorColor;

  const UnderlineTabBar({
    required this.tabTitles,
    required this.indicatorColor,
    this.controller,
    this.indicatorSize = TabBarIndicatorSize.tab,
    this.isScrollable = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.background,
        border: Border(
          bottom: BorderSide(color: theme.surface),
        ),
      ),
      child: TabBar(
        onTap: onTap,
        isScrollable: isScrollable,
        indicatorSize: indicatorSize,
        labelColor: theme.onBackground,
        labelPadding: const EdgeInsets.only(
          top: 24,
          bottom: 10,
          left: 12,
          right: 12,
        ),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3,
            color: indicatorColor,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
        ),
        labelStyle: textStyles.labelSmall,
        unselectedLabelColor: theme.onBackground,
        controller: controller,
        tabs: List.generate(
          tabTitles.length,
          (index) => Center(
            child: Text(tabTitles[index]),
          ),
        ),
      ),
    );
  }
}
