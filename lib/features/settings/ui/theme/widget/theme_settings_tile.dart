import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/common/widget/settings_tile.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';

class ThemeSettingsTile extends StatelessWidget {
  const ThemeSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocBuilder<ThemeCubit, ThemeModeOption>(
      builder: (context, currentTheme) {
        final isDarkMode = currentTheme == ThemeModeOption.dark;
        final themeLabel = isDarkMode ? localizer.dark : localizer.light;

        return SettingsTile(
          icon: Icons.palette_outlined,
          title: localizer.theme,
          subtitle: themeLabel,
          trailing: Switch(
            value: isDarkMode,
            onChanged: (value) {
              final newTheme =
                  value ? ThemeModeOption.dark : ThemeModeOption.light;
              context.read<ThemeCubit>().setThemeModeOption(newTheme);
            },
          ),
        );
      },
    );
  }
}
