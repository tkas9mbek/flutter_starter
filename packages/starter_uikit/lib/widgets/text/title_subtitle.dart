import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Screen heading that stacks a bold [title] above an optional
/// secondary-colored [subtitle], aligned per [textAlign] with [spacing]
/// between the two.
class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({
    required this.title,
    this.textAlign = TextAlign.center,
    this.spacing = 10,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextAlign textAlign;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Column(
      crossAxisAlignment: switch (textAlign) {
        TextAlign.center => CrossAxisAlignment.center,
        TextAlign.end || TextAlign.right => CrossAxisAlignment.end,
        _ => CrossAxisAlignment.start,
      },
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: titleStyle ?? textStyles.boldTitle24,
        ),
        if (subtitle != null) ...[
          SizedBox(height: spacing),
          Text(
            subtitle!,
            textAlign: textAlign,
            style:
                subtitleStyle ??
                textStyles.regularBody14.copyWith(color: theme.textSecondary),
          ),
        ],
      ],
    );
  }
}
