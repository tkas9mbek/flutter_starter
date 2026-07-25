import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/dev_mode_activator.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/features/auth/ui/login/widget/login_body.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/form/save_and_validate_form.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  void onSubmitted(BuildContext context) {
    if (saveAndValidateForm(formKey)) {
      final form = LoginForm.fromForm(formKey.currentState!.value);
      context.read<LoginBloc>().add(LoginEvent.submitted(form));
    }
  }

  void onCodeSignInPressed(BuildContext context) {
    final phoneField = formKey.currentState?.fields[LoginForm.phoneField];

    if (!(phoneField?.validate() ?? false)) {
      return;
    }

    phoneField!.save();
    unawaited(context.router.push(OtpRoute(phone: phoneField.value as String)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state case FailureLoginState(:final exception)) {
            NotificationSnackBar.showExceptionMessage(
              context,
              exception: exception,
            );
          }
        },
        builder: (context, state) => FormBuilder(
          key: formKey,
          child: DevModeActivator(
            child: Scaffold(
              appBar: TitleAppBar(title: Localizer.of(context).login),
              body: LoginBody(
                loading: state.isLoading,
                onRegisterTap: () =>
                    context.router.replace(const RegistrationRoute()),
                onLoginPressed: () => onSubmitted(context),
                onCodeSignInPressed: () => onCodeSignInPressed(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
