import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/dialogs/confirmation_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_range_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class DialogsExampleScreen extends StatelessWidget {
  const DialogsExampleScreen({super.key});

  Future<void> _showDateTimePicker(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DateTimePickerBottomSheet(
        title: localizer.dateTimePicker,
        backText: localizer.cancel,
        confirmText: localizer.confirm,
        initialDate: DateTime.now(),
      ),
    );
    if (result != null && context.mounted) {
      NotificationSnackBar.showMessage(
        context,
        isSuccess: true,
        message: 'Selected: ${result.toString().split('.')[0]}',
      );
    }
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await showModalBottomSheet<(DateTime, DateTime)>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DateRangePickerBottomSheet(
        title: localizer.dateRangePicker,
        backText: localizer.cancel,
        confirmText: localizer.confirm,
        initialDate: DateTime.now(),
      ),
    );
    if (result != null && context.mounted) {
      NotificationSnackBar.showMessage(
        context,
        isSuccess: true,
        message: 'Range: ${result.$1.toString().split(' ')[0]} - ${result.$2.toString().split(' ')[0]}',
      );
    }
  }

  Future<void> _showConfirmation(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ConfirmationBottomSheet(
        title: localizer.confirmAction,
        text: localizer.areYouSure,
        buttonText: localizer.confirm,
      ),
    );
    if ((result ?? false) && context.mounted) {
      NotificationSnackBar.showMessage(
        context,
        isSuccess: true,
        message: 'Confirmed!',
      );
    }
  }

  Future<void> _showDropdown(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DropdownBottomSheet<String>(
        title: localizer.selectOption,
        options: const ['option1', 'option2', 'option3'],
        optionLabelBuilder: (value) {
          switch (value) {
            case 'option1':
              return localizer.option1;
            case 'option2':
              return localizer.option2;
            case 'option3':
              return localizer.option3;
            default:
              return value;
          }
        },
      ),
    );
    if (result != null && context.mounted) {
      NotificationSnackBar.showMessage(
        context,
        isSuccess: true,
        message: 'Selected: $result',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.dialogs),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizer.dateTimePicker,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.showDialog,
              onPressed: () => _showDateTimePicker(context),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.dateRangePicker,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.showDialog,
              onPressed: () => _showDateRangePicker(context),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.confirmationDialog,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.showDialog,
              onPressed: () => _showConfirmation(context),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.dropdownBottomSheet,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.showDialog,
              onPressed: () => _showDropdown(context),
            ),
          ],
        ),
      ),
    );
  }
}
