import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/features/application/root/screen/authenticated_wrapper.dart';
import 'package:starter/features/application/root/screen/root_screen.dart';
import 'package:starter/features/auth/ui/login/screen/login_screen.dart';
import 'package:starter/features/auth/ui/register/screen/registration_screen.dart';
import 'package:starter/features/profile/ui/screen/profile_screen.dart';
import 'package:starter/features/settings/ui/menu/screen/settings_screen.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/calendar/screen/calendar_screen.dart';
import 'package:starter/features/task/ui/details/screen/task_details_screen.dart';
import 'package:starter/features/task/ui/list/screen/tasks_list_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: LoginRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: RegistrationRoute.page,
      path: '/register',
    ),
    AutoRoute(
      page: AuthenticatedRouter.page,
      path: '/authenticated',
      children: [
        AutoRoute(
          page: RootRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: CalendarRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: TasksListRoute.page,
              path: 'tasks',
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
            ),
          ],
        ),
        AutoRoute(
          page: TaskDetailsRoute.page,
          path: 'task/:taskId',
        ),
      ],
    ),
  ];
}
