import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/form/decoration/text_field_decoration.dart';

class BorderedTextFieldDecoration with TextFieldDecoration {
  const BorderedTextFieldDecoration();

  @override
  Widget build(BuildContext context, Widget child) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 52,
      ),
      padding: const EdgeInsets.fromLTRB(12, 7, 12, 8),
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.border,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
