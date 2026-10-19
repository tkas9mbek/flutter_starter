import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/animated_visibility.dart';

/// Inline validation message under a form control; stays in the tree and
/// animates in/out with [visible] so the layout below does not jump.
class FieldErrorText extends StatelessWidget {
  const FieldErrorText({required this.visible, this.errorText, super.key});

  final bool visible;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return AnimatedVisibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(top: 6, left: 4, right: 4),
        child: Text(
          '* ${errorText ?? ''}',
          style: textStyles.regularBody13.copyWith(color: theme.errorText),
        ),
      ),
    );
  }
}
