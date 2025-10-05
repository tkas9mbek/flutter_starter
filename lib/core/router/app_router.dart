import 'package:auto_route/auto_route.dart';
import 'package:starter/features/application/root/screen/authenticated_wrapper.dart';
import 'package:starter/features/application/root/screen/root_screen.dart';
import 'package:starter/features/auth/ui/login/screen/login_screen.dart';
import 'package:starter/features/auth/ui/register/screen/registration_screen.dart';
import 'package:starter/features/home/calendar_screen.dart';

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
          ],
        ),
      ],
    ),
  ];
}
