import 'package:flutter/material.dart';
import 'package:starter/features/settings/ui/menu/widget/settings_card.dart';
import 'package:starter/features/settings/ui/menu/widget/settings_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final localizer = Localizer.of(context);

    return SettingsCard(
      children: [
        SettingsTile(
          icon: Icons.info_outline,
          title: localizer.version,
          subtitle: '1.0.0',
        ),
        const Divider(height: 1),
        SettingsTile(
          icon: Icons.description_outlined,
          title: localizer.termsAndConditions,
          trailing: Icon(
            Icons.chevron_right,
            color: theme.textSecondary,
          ),
          onTap: () {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: false,
              message: localizer.termsComingSoon,
            );
          },
        ),
        const Divider(height: 1),
        SettingsTile(
          icon: Icons.privacy_tip_outlined,
          title: localizer.privacyPolicy,
          trailing: Icon(
            Icons.chevron_right,
            color: theme.textSecondary,
          ),
          onTap: () {
            NotificationSnackBar.showMessage(
              context,
              isSuccess: false,
              message: localizer.privacyPolicyComingSoon,
            );
          },
        ),
      ],
    );
  }
}
