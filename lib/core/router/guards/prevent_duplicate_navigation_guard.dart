import 'package:auto_route/auto_route.dart';

class PreventDuplicateNavigationGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (router.current.route == resolver.route) {
      router.maybePop();
    } else {
      resolver.next(true);
    }
  }
}
