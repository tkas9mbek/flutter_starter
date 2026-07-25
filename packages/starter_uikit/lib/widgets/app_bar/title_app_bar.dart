import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/app_bar/app_bar_content.dart';
import 'package:starter_uikit/widgets/app_bar/base_app_bar.dart';

/// Standard flat app bar with a centered [title], optionally accompanied by
/// a [subtitle], trailing [actions], and a [bottom] widget.
class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleAppBar({
    required this.title,
    this.automaticallyImplyLeading = true,
    this.height = 52,
    this.subtitle,
    this.actions,
    this.bottom,
    super.key,
  });

  final String title;
  final Widget? subtitle;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double height;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      height: height,
      bottom: bottom,
      child: AppBarContent(
        title: title,
        subtitle: subtitle,
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
    );
  }
}
