import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_uikit/example/cubit/theme_cubit.dart';
import 'package:starter_uikit/example/router/example_router.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class UikitMenuScreen extends StatelessWidget {
  const UikitMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(
        title: localizer.uiKit,
        actions: [
          IconButton(
            icon: SvgIcon(UiSvgIcons.sunTheme, color: theme.textPrimary),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GroupedRowsCard(
              children: [
                AppListTile(
                  icon: UiSvgIcons.plusSign,
                  title: localizer.buttons,
                  subtitle: localizer.buttonsDescription,
                  onTap: () => context.router.push(const ButtonsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.tickMark,
                  title: localizer.formFields,
                  subtitle: localizer.formFieldsDescription,
                  onTap: () => context.router.push(FormFieldsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.infoCircle,
                  title: localizer.statusWidgets,
                  subtitle: localizer.statusWidgetsDescription,
                  onTap: () =>
                      context.router.push(const StatusWidgetsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.chevronLeft,
                  title: localizer.appBars,
                  subtitle: localizer.appBarsDescription,
                  onTap: () => context.router.push(const AppBarsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.notificationBell,
                  title: localizer.dialogs,
                  subtitle: localizer.dialogsDescription,
                  onTap: () => context.router.push(const DialogsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.documentGlyph,
                  title: localizer.textWidgets,
                  subtitle: localizer.textWidgetsDescription,
                  onTap: () =>
                      context.router.push(const TextWidgetsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.inboxTray,
                  title: localizer.miscWidgets,
                  subtitle: localizer.miscWidgetsDescription,
                  onTap: () =>
                      context.router.push(const MiscWidgetsExampleRoute()),
                ),
                AppListTile(
                  icon: UiSvgIcons.menuBars,
                  title: localizer.paginationWidgets,
                  subtitle: localizer.paginationWidgetsDescription,
                  onTap: () =>
                      context.router.push(const PaginationExampleRoute()),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              localizer.aboutUIKit,
              style: textStyles.mediumBody13.copyWith(
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Text(
                localizer.uiKitDescription,
                style: textStyles.regularBody14.copyWith(
                  color: theme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
