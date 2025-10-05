import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        title: Localizer.of(context).calendar,
      ),
      body: Center(
        child: AppElevatedButton.big(
          context: context,
          text: Localizer.of(context).toLogout,
          onPressed: () =>
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
        ),
      ),
    );
  }
}
