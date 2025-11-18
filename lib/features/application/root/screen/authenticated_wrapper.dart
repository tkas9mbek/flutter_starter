import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/application/root/widget/user_provider.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/ui/bloc/profile_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/misc/safe_vertical_box.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

@RoutePage(name: 'AuthenticatedRouter')
class AuthenticatedWrapper extends StatelessWidget {
  const AuthenticatedWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(
        getIt<ProfileRepository>(),
      )..add(const ProfileEvent.requested()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const Scaffold(
            body: CustomCircularProgressIndicator(),
          ),
          failure: (state) => Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: FailureWidgetLarge(
                    exception: state.exception,
                    onRetry: () => context
                        .read<ProfileBloc>()
                        .add(const ProfileEvent.requested()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppOutlinedButton.medium(
                    context: context,
                    text: Localizer.of(context).toLogout,
                    onPressed: () => context
                        .read<AuthBloc>()
                        .add(const AuthEvent.logoutRequested()),
                  ),
                ),
                const SafeVerticalBox(height: 20),
              ],
            ),
          ),
          success: (state) => UserProvider(
            user: state.user,
            child: const AutoRouter(),
          ),
        ),
      ),
    );
  }
}
