import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/form/decoration/text_field_decoration.dart';

class FilledTextFieldDecoration with TextFieldDecoration {
  const FilledTextFieldDecoration({
    this.hasBorder = false,
    this.color,
  });

  final Color? color;
  final bool hasBorder;

  @override
  Widget build(BuildContext context, Widget child) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 52,
      ),
      padding: const EdgeInsets.fromLTRB(12, 7, 12, 8),
      decoration: BoxDecoration(
        color: color ?? theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: hasBorder
            ? Border.all(
                color: theme.border,
                width: 1,
              )
            : null,
      ),
      child: child,
    );
  }
}
