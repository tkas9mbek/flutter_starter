import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class LanguageSelectorDialog extends StatelessWidget {
  const LanguageSelectorDialog({
    required this.languageCubit,
    super.key,
  });

  final LanguageCubit languageCubit;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final localizer = Localizer.of(context);

    return AlertDialog(
      title: Text(localizer.selectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: languageOptionsAvailable.map((language) {
          return BlocBuilder<LanguageCubit, LanguageOption>(
            bloc: languageCubit,
            builder: (context, currentLanguage) {
              final isSelected = currentLanguage == language;

              return ListTile(
                title: Text(language.name),
                trailing:
                    isSelected ? Icon(Icons.check, color: theme.primary) : null,
                onTap: () {
                  languageCubit.setLanguageOption(language);
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
