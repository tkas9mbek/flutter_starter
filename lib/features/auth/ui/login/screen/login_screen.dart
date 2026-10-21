import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/environment/ui/switcher/widget/dev_mode_activator.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter/features/auth/ui/login/widget/login_body.dart';
import 'package:starter_uikit/widgets/form/app_form.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<AppFormState>();

  void onSubmitted(BuildContext context) {
    if (formKey.currentState!.saveAndValidate()) {
      final form = LoginForm.fromForm(formKey.currentState!.value);
      context.read<LoginBloc>().add(LoginEvent.submitted(form));
    }
  }

  void onCodeSignInPressed(BuildContext context) {
    final form = formKey.currentState!;

    if (!form.validateField(LoginForm.phoneField)) {
      return;
    }

    final phoneField = form.fields[LoginForm.phoneField]!..save();
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
        builder: (context, state) => AppForm(
          key: formKey,
          child: DevModeActivator(
            child: Scaffold(
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
