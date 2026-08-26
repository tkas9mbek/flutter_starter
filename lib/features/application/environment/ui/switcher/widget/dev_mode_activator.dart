import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter_uikit/example/screens/application.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';
import 'package:starter_uikit/widgets/misc/tap_activator.dart';

/// Entries in the hidden dev menu opened by [DevModeActivator].
enum _DevModeMenuOption { environment, uiKitExamples }

/// Reveals a hidden dev menu when [child] is tapped repeatedly — the only
/// way to reach the environment switcher and the internal UIKit example
/// gallery, since neither has a permanently visible entry point.
class DevModeActivator extends StatelessWidget {
  const DevModeActivator({required this.child, super.key});

  final Widget child;

  void openDevMenu(BuildContext context) {
    unawaited(
      BottomSheetScreen.show(
        context: context,
        builder: (_) => DropdownBottomSheet<_DevModeMenuOption>(
          title: 'Dev Menu',
          options: _DevModeMenuOption.values,
          optionLabelBuilder: (option) => switch (option) {
            _DevModeMenuOption.environment => 'Environment',
            _DevModeMenuOption.uiKitExamples => 'UI Kit Examples',
          },
        ),
      ).then((selectedOption) {
        if (selectedOption == null || !context.mounted) {
          return;
        }

        switch (selectedOption) {
          case _DevModeMenuOption.environment:
            openEnvironmentSettings(context);
          case _DevModeMenuOption.uiKitExamples:
            openUikitExamples(context);
        }
      }),
    );
  }

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

  /// Pushes the self-contained UIKit example gallery as a full-screen
  /// route on the root navigator, isolated from the running app's own
  /// router/localization/theme.
  void openUikitExamples(BuildContext context) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(builder: (_) => const TestingApplication()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapActivator(onActivated: () => openDevMenu(context), child: child);
  }
}
