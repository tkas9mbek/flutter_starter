import 'package:flutter/material.dart';
import 'package:uikit/widgets/app_bar/app_bar_content.dart';
import 'package:uikit/widgets/app_bar/base_app_bar.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// App bar with white background, small elevation and shadow, and a title.
  /// The title can be accompanied by a subtitle and actions.
  /// * [bottom] is an optional widget that can be placed at the bottom of the app bar.
  const TitleAppBar({
    required this.title,
    this.subtitle,
    this.actions,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.height = 52,
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
