import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/profile/ui/bloc/profile_bloc.dart';
import 'package:starter/features/profile/ui/widget/profile_failure_view.dart';
import 'package:starter/features/profile/ui/widget/profile_success_view.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/starter_uikit.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(title: Localizer.of(context).profile),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => state.when(
          initial: () => const Center(
                child: CustomCircularProgressIndicator(),
              ),
          loading: () => const Center(
                child: CustomCircularProgressIndicator(),
              ),
          success: (user) => ProfileSuccessView(user: user),
          failure: (exception) => ProfileFailureView(exception: exception),
        ),
      ),
    );
  }
}
