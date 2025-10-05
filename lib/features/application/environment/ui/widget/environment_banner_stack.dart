import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/bloc/environment_cubit.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class EnvironmentBannerStack extends StatelessWidget {
  const EnvironmentBannerStack({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: BlocBuilder<EnvironmentCubit, AppEnvironment>(
                builder: (context, env) => env.showBanner
                    ? Text(
                        env.name,
                        style: textStyles.regularBody13.copyWith(
                          color: theme.error,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
