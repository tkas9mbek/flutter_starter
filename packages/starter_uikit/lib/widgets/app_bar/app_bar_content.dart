import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class AppBarContent extends StatelessWidget {
  /// Represents the content of the AppBar, base widget for most appbars.
  const AppBarContent({
    required this.title,
    this.subtitle,
    this.actions,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final String title;
  final Widget? subtitle;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (automaticallyImplyLeading && Navigator.canPop(context)) ...[
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 17, 16, 12),
                child: SvgPicture.asset(
                  UiSvgIcons.chevronLeft,
                  package: UiConsts.package,
                ),
              ),
            ),
          ),
        ],
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...?actions,
            ],
          ),
        ),
        if (subtitle == null) ...[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  title,
                  style: textStyles.mediumTitle20,
                ),
              ],
            ),
          ),
        ] else ...[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Text(
                  title,
                  style: textStyles.mediumTitle20,
                ),
                const SizedBox(height: 2),
                subtitle!,
                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
