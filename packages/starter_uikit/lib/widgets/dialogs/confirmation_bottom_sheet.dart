import 'package:flutter/material.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';

/// A bottom sheet asking the user to confirm an action, showing a [title],
/// optional descriptive [text], and a full-width confirm button.
/// Pops with `true` when confirmed; dismissing otherwise yields `null`.
class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    required this.title,
    required this.buttonText,
    this.showCloseButton = true,
    this.text,
    super.key,
  });

  final String title;
  final String? text;
  final String buttonText;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return BottomSheetScreen(
      title: title,
      showCloseButton: showCloseButton,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null) ...[
            const SizedBox(height: 8),
            Text(text!, style: textStyles.regularBody13),
          ],
          const SizedBox(height: 16),
          AppElevatedButton.big(
            context: context,
            text: buttonText,
            width: double.infinity,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
