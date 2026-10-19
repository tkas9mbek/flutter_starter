import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';

class ThemeSettingsTile extends StatelessWidget {
  const ThemeSettingsTile({super.key});

  String _getThemeLabel(BuildContext context, ThemeModeOption option) {
    final localizer = Localizer.of(context);

    return switch (option) {
      ThemeModeOption.light => localizer.light,
      ThemeModeOption.dark => localizer.dark,
      ThemeModeOption.system => localizer.system,
    };
  }

  Future<void> _showThemeSelector(BuildContext context) async {
    final currentTheme = context.read<ThemeCubit>().state;
    final localizer = Localizer.of(context);

    final selected = await BottomSheetScreen.show<ThemeModeOption>(
      context: context,
      builder: (context) => DropdownBottomSheet<ThemeModeOption>(
        title: localizer.theme,
        options: ThemeModeOption.values,
        selected: currentTheme,
        optionLabelBuilder: (option) => _getThemeLabel(context, option),
      ),
    );

    if (selected != null && context.mounted) {
      context.read<ThemeCubit>().setThemeModeOption(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocBuilder<ThemeCubit, ThemeModeOption>(
      builder: (context, currentTheme) => AppListTile(
        icon: UiSvgIcons.sunTheme,
        title: localizer.theme,
        value: _getThemeLabel(context, currentTheme),
        onTap: () => _showThemeSelector(context),
      ),
    );
  }
}
