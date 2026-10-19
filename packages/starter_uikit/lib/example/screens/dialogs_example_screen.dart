import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/confirmation_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_range_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/date_time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/dialogs/time_picker_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class DialogsExampleScreen extends StatelessWidget {
  const DialogsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(title: localizer.dialogs),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            localizer.dialogsDescription,
            style: textStyles.mediumBody13.copyWith(color: theme.textSecondary),
          ),
          const SizedBox(height: 8),
          const GroupedRowsCard(
            children: [
              _DateTimePickerTile(),
              _DateRangePickerTile(),
              _TimePickerTile(),
              _ConfirmationTile(),
              _DropdownTile(),
            ],
          ),
        ],
      ),
    );
  }
}

void _notify(BuildContext context, String text) => NotificationSnackBar.show(
  context,
  NotificationSnackBar.success(text: text),
);

String _formatDate(DateTime date) => date.toString().split(' ')[0];

class _DateTimePickerTile extends StatelessWidget {
  const _DateTimePickerTile();

  Future<void> _show(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await BottomSheetScreen.show<DateTime>(
      context: context,
      builder: (context) => DateTimePickerBottomSheet(
        title: localizer.dateTimePicker,
        backText: localizer.cancel,
        confirmText: localizer.confirm,
        initialDate: DateTime.now(),
      ),
    );
    if (result != null && context.mounted) {
      _notify(context, 'Selected: ${_formatDate(result)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      icon: UiSvgIcons.calendarDates,
      title: UikitLocalizer.of(context).dateTimePicker,
      onTap: () => _show(context),
    );
  }
}

class _DateRangePickerTile extends StatelessWidget {
  const _DateRangePickerTile();

  Future<void> _show(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await BottomSheetScreen.show<(DateTime, DateTime)>(
      context: context,
      builder: (context) => DateRangePickerBottomSheet(
        title: localizer.dateRangePicker,
        backText: localizer.cancel,
        confirmText: localizer.confirm,
        initialDate: DateTime.now(),
      ),
    );
    if (result != null && context.mounted) {
      final (from, to) = result;
      _notify(context, 'Range: ${_formatDate(from)} - ${_formatDate(to)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      icon: UiSvgIcons.calendarDates,
      title: UikitLocalizer.of(context).dateRangePicker,
      onTap: () => _show(context),
    );
  }
}

class _TimePickerTile extends StatelessWidget {
  const _TimePickerTile();

  static const _title = 'Time Picker';

  Future<void> _show(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await BottomSheetScreen.show<TimeOfDay>(
      context: context,
      builder: (context) => TimePickerBottomSheet(
        title: _title,
        backText: localizer.cancel,
        confirmText: localizer.confirm,
      ),
    );
    if (result != null && context.mounted) {
      _notify(context, 'Selected: ${result.format(context)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      icon: UiSvgIcons.clockTime,
      title: _title,
      onTap: () => _show(context),
    );
  }
}

class _ConfirmationTile extends StatelessWidget {
  const _ConfirmationTile();

  Future<void> _show(BuildContext context) async {
    final localizer = UikitLocalizer.of(context);
    final result = await BottomSheetScreen.show<bool>(
      context: context,
      builder: (context) => ConfirmationBottomSheet(
        title: localizer.confirmAction,
        text: localizer.areYouSure,
        buttonText: localizer.confirm,
      ),
    );
    if ((result ?? false) && context.mounted) {
      _notify(context, 'Confirmed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      icon: UiSvgIcons.infoCircle,
      title: UikitLocalizer.of(context).confirmationDialog,
      onTap: () => _show(context),
    );
  }
}

class _DropdownTile extends StatefulWidget {
  const _DropdownTile();

  @override
  State<_DropdownTile> createState() => _DropdownTileState();
}

class _DropdownTileState extends State<_DropdownTile> {
  String? _selected;

  Future<void> _show() async {
    final localizer = UikitLocalizer.of(context);
    final result = await BottomSheetScreen.show<String>(
      context: context,
      builder: (context) => DropdownBottomSheet<String>(
        title: localizer.selectOption,
        options: [localizer.option1, localizer.option2, localizer.option3],
        selected: _selected,
      ),
    );
    if (result != null && mounted) {
      setState(() => _selected = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      icon: UiSvgIcons.menuBars,
      title: UikitLocalizer.of(context).dropdownBottomSheet,
      value: _selected,
      onTap: _show,
    );
  }
}
