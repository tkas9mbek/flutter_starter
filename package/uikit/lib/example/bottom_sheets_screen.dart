import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/app_bar/title_app_bar.dart';
import 'package:uikit/widgets/button/app_base_button.dart';
import 'package:uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:uikit/widgets/dialogs/confirmation_bottom_sheet.dart';
import 'package:uikit/widgets/dialogs/dropdown_bottom_sheet.dart';

class BottomSheetsScreen extends StatelessWidget {
  const BottomSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Scaffold(
      appBar: const TitleAppBar(title: 'BottomSheets'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              AppBaseButton.flat(
                theme: theme,
                text: 'Confirmation',
                onPressed: () => BottomSheetScreen.show(
                  context: context,
                  builder: (_) => const ConfirmationBottomSheet(
                    title: 'Confirmation',
                    text: 'Are you sure you want to delete this item?',
                    buttonText: 'Delete',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AppBaseButton.flat(
                theme: theme,
                text: 'Dropdown Bottom Sheet',
                onPressed: () => BottomSheetScreen.show(
                  context: context,
                  builder: (_) => const DropdownBottomSheet(
                    title: 'Dropdown',
                    options: [true, false],
                    selected: true,
                    showCloseButton: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
