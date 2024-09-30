import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_starter/resources/resources.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

class AppCheckBox extends StatelessWidget {
  /// Checkbox with a tick icon when selected.
  const AppCheckBox({
    required this.selected,
    required this.enabled,
    this.label,
    super.key,
  });

  final bool selected;
  final bool enabled;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Row(
      mainAxisSize: label == null ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Container(
          height: 22,
          width: 22,
          decoration: selected
              ? BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(4),
                )
              : BoxDecoration(
                  border: Border.all(
                    color: theme.border,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
          child: selected
              ? Center(
                  child: SvgPicture.asset(SvgIcons.tick),
                )
              : null,
        ),
        if (label != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label ?? '',
              style: textStyles.bodyLarge.copyWith(
                color: enabled ? null : theme.onBackground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
