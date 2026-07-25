import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/tap_activator.dart';
/// Reveals the environment switcher when [child] is tapped repeatedly — a
/// hidden gesture for reaching dev settings without a visible control.
class DevModeActivator extends StatelessWidget {
  const DevModeActivator({required this.child, super.key});

  final Widget child;

  void openEnvironmentSettings(BuildContext context) {
    final envCubit = context.read<EnvironmentCubit>();

    final environments = [
      AppEnvironment.mock(),
      AppEnvironment.dev(),
      AppEnvironment.prod(),
    ];

    unawaited(
      BottomSheetScreen.show(
        context: context,
        isDismissible: false,
        builder: (_) => DropdownBottomSheet<AppEnvironment>(
          options: environments,
          selected: envCubit.state,
          optionLabelBuilder: (env) => '${env.name} ${env.baseApiUrl}',
        ),
      ).then((selectedEnvironment) {
        if (selectedEnvironment != null && context.mounted) {
          unawaited(envCubit.setEnvironment(selectedEnvironment));
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapActivator(
      onActivated: () => openEnvironmentSettings(context),
      child: child,
    );
  }
}
