// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'example_router.dart';

/// generated route for
/// [AppBarsExampleScreen]
class AppBarsExampleRoute extends PageRouteInfo<void> {
  const AppBarsExampleRoute({List<PageRouteInfo>? children})
    : super(AppBarsExampleRoute.name, initialChildren: children);

  static const String name = 'AppBarsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppBarsExampleScreen();
    },
  );
}

/// generated route for
/// [ButtonsExampleScreen]
class ButtonsExampleRoute extends PageRouteInfo<void> {
  const ButtonsExampleRoute({List<PageRouteInfo>? children})
    : super(ButtonsExampleRoute.name, initialChildren: children);

  static const String name = 'ButtonsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ButtonsExampleScreen();
    },
  );
}

/// generated route for
/// [DialogsExampleScreen]
class DialogsExampleRoute extends PageRouteInfo<void> {
  const DialogsExampleRoute({List<PageRouteInfo>? children})
    : super(DialogsExampleRoute.name, initialChildren: children);

  static const String name = 'DialogsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DialogsExampleScreen();
    },
  );
}

/// generated route for
/// [FormFieldsExampleScreen]
class FormFieldsExampleRoute extends PageRouteInfo<FormFieldsExampleRouteArgs> {
  FormFieldsExampleRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        FormFieldsExampleRoute.name,
        args: FormFieldsExampleRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'FormFieldsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FormFieldsExampleRouteArgs>(
        orElse: () => const FormFieldsExampleRouteArgs(),
      );
      return FormFieldsExampleScreen(key: args.key);
    },
  );
}

class FormFieldsExampleRouteArgs {
  const FormFieldsExampleRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FormFieldsExampleRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MiscWidgetsExampleScreen]
class MiscWidgetsExampleRoute extends PageRouteInfo<void> {
  const MiscWidgetsExampleRoute({List<PageRouteInfo>? children})
    : super(MiscWidgetsExampleRoute.name, initialChildren: children);

  static const String name = 'MiscWidgetsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MiscWidgetsExampleScreen();
    },
  );
}

/// generated route for
/// [StatusWidgetsExampleScreen]
class StatusWidgetsExampleRoute extends PageRouteInfo<void> {
  const StatusWidgetsExampleRoute({List<PageRouteInfo>? children})
    : super(StatusWidgetsExampleRoute.name, initialChildren: children);

  static const String name = 'StatusWidgetsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StatusWidgetsExampleScreen();
    },
  );
}

/// generated route for
/// [TextWidgetsExampleScreen]
class TextWidgetsExampleRoute extends PageRouteInfo<void> {
  const TextWidgetsExampleRoute({List<PageRouteInfo>? children})
    : super(TextWidgetsExampleRoute.name, initialChildren: children);

  static const String name = 'TextWidgetsExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TextWidgetsExampleScreen();
    },
  );
}

/// generated route for
/// [UikitMenuScreen]
class UikitMenuRoute extends PageRouteInfo<void> {
  const UikitMenuRoute({List<PageRouteInfo>? children})
    : super(UikitMenuRoute.name, initialChildren: children);

  static const String name = 'UikitMenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UikitMenuScreen();
    },
  );
}
