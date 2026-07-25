import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/application/root/widget/user_provider.dart';
import 'package:starter/features/profile/ui/overview/bloc/user_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

@RoutePage(name: 'AuthenticatedRouter')
class AuthenticatedWrapper extends StatelessWidget {
  const AuthenticatedWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          getIt<UserBloc>()..add(const UserEvent.requested()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => switch (state) {
          FailureUserState(:final exception) => Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: FailureWidget.large(
                    exception: exception,
                    onRetry: () => context.read<UserBloc>().add(
                      const UserEvent.requested(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppOutlinedButton.medium(
                    context: context,
                    text: Localizer.of(context).toLogout,
                    onPressed: () => context.read<AuthBloc>().add(
                      const AuthEvent.logoutRequested(),
                    ),
                  ),
                ),
                const SafeVerticalBox(height: 20),
              ],
            ),
          ),
          SuccessUserState(:final user) => UserProvider(
            user: user,
            child: const AutoRouter(),
          ),
          InitialUserState() || LoadingUserState() => const Scaffold(
            body: CustomCircularProgressIndicator.adaptive(),
          ),
        },
      ),
    );
  }
}
