import 'package:flutter/material.dart';
import 'package:flutter_starter/theme/theme_provider.dart';
import 'package:flutter_starter/uikit/button/app_base_button.dart';
import 'package:flutter_starter/uikit/dialogs/bottom_sheet_screen.dart';

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
    final theme = ThemeProvider.of(context).theme;

    return BottomSheetScreen(
      title: title,
      showCloseButton: showCloseButton,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null) ...[
            const SizedBox(height: 8),
            Text(
              text!,
              style: textStyles.bodyLarge,
            ),
          ],
          const SizedBox(height: 16),
          AppBaseButton.elevated(
            theme: theme,
            text: buttonText,
            width: double.infinity,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
