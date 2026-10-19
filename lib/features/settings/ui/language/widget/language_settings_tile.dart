import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';

class LanguageSettingsTile extends StatelessWidget {
  const LanguageSettingsTile({super.key});

  Future<void> _showLanguageSelector(BuildContext context) async {
    final currentLanguage = context.read<LanguageCubit>().state;
    final localizer = Localizer.of(context);

    final selected = await BottomSheetScreen.show<LanguageOption>(
      context: context,
      builder: (context) => DropdownBottomSheet<LanguageOption>(
        title: localizer.selectLanguage,
        options: languageOptionsAvailable,
        selected: currentLanguage,
        optionLabelBuilder: (option) => option.name,
      ),
    );

    if (selected != null && context.mounted) {
      context.read<LanguageCubit>().setLanguageOption(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocBuilder<LanguageCubit, LanguageOption>(
      builder: (context, currentLanguage) => AppListTile(
        icon: UiSvgIcons.globeLanguage,
        title: localizer.language,
        value: currentLanguage.name,
        onTap: () => _showLanguageSelector(context),
      ),
    );
  }
}
