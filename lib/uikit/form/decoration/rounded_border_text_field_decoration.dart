import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/form/decoration/text_field_decoration.dart';

class RoundedBorderTextFieldDecoration with TextFieldDecoration {
  const RoundedBorderTextFieldDecoration();

  @override
  Widget build(BuildContext context, Widget child) {
    final theme = ThemeProvider.of(context).theme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: theme.background,
        border: Border.all(
          color: theme.border,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
