import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/ui/common/widget/about_settings_section.dart';
import 'package:starter/features/settings/ui/common/widget/section_header.dart';
import 'package:starter/features/settings/ui/common/widget/settings_card.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/language/widget/language_settings_tile.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';
import 'package:starter/features/settings/ui/theme/widget/theme_settings_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(getIt<SettingsRepository>()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(getIt<SettingsRepository>()),
        ),
      ],
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.settings),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionHeader(title: localizer.appearance),
          const SizedBox(height: 12),
          const SettingsCard(
            children: [
              ThemeSettingsTile(),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeader(title: localizer.language),
          const SizedBox(height: 12),
          const SettingsCard(
            children: [
              LanguageSettingsTile(),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeader(title: localizer.about),
          const SizedBox(height: 12),
          const AboutSettingsSection(),
        ],
      ),
    );
  }
}
