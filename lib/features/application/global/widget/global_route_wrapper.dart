import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';

class GlobalRouteWrapper extends StatelessWidget {
  const GlobalRouteWrapper({
    required this.router,
    required this.child,
    super.key,
  });

  final AppRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // New users land on login too; point this at an onboarding
        // route when the project adds one.
        if (state is UnauthenticatedAuthState || state is NewUserAuthState) {
          unawaited(router.replaceAll([const LoginRoute()]));
        }

        if (state is AuthenticatedAuthState) {
          unawaited(router.replaceAll([const AuthenticatedRouter()]));
        }
      },
      child: child,
    );
  }
}
