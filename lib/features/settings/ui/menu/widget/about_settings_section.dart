import 'package:flutter/material.dart';
import 'package:starter/core/global/core_consts.dart';
import 'package:starter/features/settings/ui/menu/widget/settings_card.dart';
import 'package:starter/features/settings/ui/menu/widget/settings_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final localizer = Localizer.of(context);

    return SettingsCard(
      children: [
        SettingsTile(
          icon: UiSvgIcons.infoCircle,
          title: localizer.version,
          subtitle: CoreConsts.appVersion,
        ),
        const Divider(height: 1),
        SettingsTile(
          icon: UiSvgIcons.documentGlyph,
          title: localizer.termsAndConditions,
          trailing: SvgIcon(
            UiSvgIcons.chevronRight,
            size: 24,
            color: theme.textSecondary,
          ),
          onTap: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.error(text: localizer.termsComingSoon),
          ),
        ),
        const Divider(height: 1),
        SettingsTile(
          icon: UiSvgIcons.shieldDone,
          title: localizer.privacyPolicy,
          trailing: SvgIcon(
            UiSvgIcons.chevronRight,
            size: 24,
            color: theme.textSecondary,
          ),
          onTap: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.error(text: localizer.privacyPolicyComingSoon),
          ),
        ),
      ],
    );
  }
}
