import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_logger/widget/request_logger_button.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// Puts the environment banner in a slim strip above the app, so it never
/// covers an app-bar title. The strip takes over the status-bar inset.
class EnvironmentBannerStack extends StatelessWidget {
  const EnvironmentBannerStack({
    required this.child,
    required this.navigatorKey,
    super.key,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvironmentCubit, AppEnvironment>(
      builder: (context, env) => Column(
        children: [
          if (env.showBanner) ...[
            _BannerStrip(env: env, navigatorKey: navigatorKey),
          ],
          Expanded(
            key: const ValueKey('app-content'),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: env.showBanner,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerStrip extends StatelessWidget {
  const _BannerStrip({required this.env, required this.navigatorKey});

  final AppEnvironment env;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return ColoredBox(
      color: theme.background,
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: double.infinity,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: MediaQuery.withNoTextScaling(
                child: Center(
                  child: RequestLoggerButton(
                    label: env.name,
                    color: env.useMock ? theme.info : theme.warning,
                    navigatorKey: navigatorKey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
