import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/ui/common/widget/settings_tile.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/language/widget/language_selector_dialog.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class LanguageSettingsTile extends StatelessWidget {
  const LanguageSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final localizer = Localizer.of(context);

    return BlocBuilder<LanguageCubit, LanguageOption>(
      builder: (context, currentLanguage) => SettingsTile(
        icon: Icons.language_outlined,
        title: localizer.language,
        subtitle: currentLanguage.name,
        trailing: Icon(
          Icons.chevron_right,
          color: theme.textSecondary,
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => LanguageSelectorDialog(
            languageCubit: context.read<LanguageCubit>(),
          ),
        ),
      ),
    );
  }
}
