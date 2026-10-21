import 'package:flutter/material.dart';
import 'package:starter/core/global/core_consts.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return GroupedRowsCard(
      children: [
        AppListTile(
          icon: UiSvgIcons.infoCircle,
          title: localizer.version,
          value: CoreConsts.appVersion,
        ),
        AppListTile(
          icon: UiSvgIcons.documentGlyph,
          title: localizer.termsAndConditions,
          onTap: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.information(text: localizer.termsComingSoon),
          ),
        ),
        AppListTile(
          icon: UiSvgIcons.shieldDone,
          title: localizer.privacyPolicy,
          onTap: () => NotificationSnackBar.show(
            context,
            NotificationSnackBar.information(
              text: localizer.privacyPolicyComingSoon,
            ),
          ),
        ),
      ],
    );
  }
}
