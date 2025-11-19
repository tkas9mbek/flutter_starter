import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/bloc/environment_cubit.dart';
import 'package:starter_uikit/widgets/dev_tools/tap_activator.dart';
import 'package:starter_uikit/widgets/dialogs/bottom_sheet_screen.dart';
import 'package:starter_uikit/widgets/dialogs/dropdown_bottom_sheet.dart';

/// Allows to switch environment when widget wrapped in this widget is tapped 7 times.
class DevModeActivator extends StatelessWidget {
  const DevModeActivator({
    required this.child,
    super.key,
  });

  final Widget child;

  void openEnvironmentSettings(BuildContext context) {
    final envCubit = context.read<EnvironmentCubit>();

    final environments = [
      AppEnvironment.mock(),
      AppEnvironment.dev(),
      AppEnvironment.prod(),
    ];

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
        envCubit.setEnvironment(selectedEnvironment);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapActivator(
      onActivated: () => openEnvironmentSettings(context),
      child: child,
    );
  }
}
