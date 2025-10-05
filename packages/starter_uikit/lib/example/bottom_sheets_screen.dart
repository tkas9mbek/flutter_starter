import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/confirmation_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';

class BottomSheetsScreen extends StatelessWidget {
  const BottomSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TitleAppBar(title: 'BottomSheets'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              AppElevatedButton.medium(
                context: context,
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
              AppElevatedButton.medium(
                context: context,
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
