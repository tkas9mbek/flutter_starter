import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/configs/ui_consts.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/bottom/bottom_nav_item.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static BuildContext? maybeContext(BuildContext context) {
    final result = context.findAncestorStateOfType<_RootScreenState>();
    return result?.context;
  }

  static BuildContext context(BuildContext context) {
    final result = context.findAncestorStateOfType<_RootScreenState>();
    if (result == null) {
      throw Exception(
        'RootScreen.of() called with a context that does not contain a RootScreen.',
      );
    }
    return result.context;
  }

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    final routes = [
      const CalendarRoute(),
      const CalendarRoute(),
      const CalendarRoute(),
      const CalendarRoute(),
    ];

    return AutoTabsScaffold(
      routes: routes,
      bottomNavigationBuilder: (context, tabsRouter) => DecoratedBox(
        decoration: BoxDecoration(
          color: theme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              BottomNavItem(
                iconPath: UiSvgIcons.calendar,
                package: UiConsts.package,
                title: Localizer.of(context).calendar,
                isActive: tabsRouter.activeIndex == 0,
                onTap: () => context.router.replaceAll([routes[0]]),
              ),
              BottomNavItem(
                iconPath: UiSvgIcons.calendar,
                package: UiConsts.package,
                title: Localizer.of(context).calendar,
                isActive: tabsRouter.activeIndex == 0,
                onTap: () => context.router.replaceAll([routes[0]]),
              ),
              BottomNavItem(
                iconPath: UiSvgIcons.calendar,
                package: UiConsts.package,
                title: Localizer.of(context).calendar,
                isActive: tabsRouter.activeIndex == 0,
                onTap: () => context.router.replaceAll([routes[0]]),
              ),
              BottomNavItem(
                iconPath: UiSvgIcons.calendar,
                package: UiConsts.package,
                title: Localizer.of(context).calendar,
                isActive: tabsRouter.activeIndex == 0,
                onTap: () => context.router.replaceAll([routes[0]]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
