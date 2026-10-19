import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/features/settings/ui/language/widget/language_settings_tile.dart';
import 'package:starter/features/settings/ui/menu/widget/about_settings_section.dart';
import 'package:starter/features/settings/ui/menu/widget/section_header.dart';
import 'package:starter/features/settings/ui/theme/widget/theme_settings_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.settings),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionHeader(title: localizer.appearance),
          const SizedBox(height: 8),
          const GroupedRowsCard(children: [ThemeSettingsTile()]),
          const SizedBox(height: 24),
          SectionHeader(title: localizer.language),
          const SizedBox(height: 8),
          const GroupedRowsCard(children: [LanguageSettingsTile()]),
          const SizedBox(height: 24),
          SectionHeader(title: localizer.about),
          const SizedBox(height: 8),
          const AboutSettingsSection(),
        ],
      ),
    );
  }
}
