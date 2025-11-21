import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/example/screens/app_bars_example_screen.dart';
import 'package:starter_uikit/example/screens/buttons_example_screen.dart';
import 'package:starter_uikit/example/screens/dialogs_example_screen.dart';
import 'package:starter_uikit/example/screens/form_fields_example_screen.dart';
import 'package:starter_uikit/example/screens/misc_widgets_example_screen.dart';
import 'package:starter_uikit/example/screens/status_widgets_example_screen.dart';
import 'package:starter_uikit/example/screens/text_widgets_example_screen.dart';
import 'package:starter_uikit/example/screens/uikit_menu_screen.dart';

part 'example_router.gr.dart';

/// **INTERNAL USE ONLY**: Router configuration for UIKit examples.
@visibleForTesting
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ExampleRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: UikitMenuRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: ButtonsExampleRoute.page,
      path: '/buttons',
    ),
    AutoRoute(
      page: FormFieldsExampleRoute.page,
      path: '/forms',
    ),
    AutoRoute(
      page: StatusWidgetsExampleRoute.page,
      path: '/status',
    ),
    AutoRoute(
      page: AppBarsExampleRoute.page,
      path: '/appbars',
    ),
    AutoRoute(
      page: DialogsExampleRoute.page,
      path: '/dialogs',
    ),
    AutoRoute(
      page: TextWidgetsExampleRoute.page,
      path: '/text',
    ),
    AutoRoute(
      page: MiscWidgetsExampleRoute.page,
      path: '/misc',
    ),
  ];
}
