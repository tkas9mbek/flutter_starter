import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';

/// Replaces the route stack when the auth status changes. Placed in a
/// `Nested` list, which supplies the child.
class GlobalRouteWrapper extends SingleChildStatelessWidget {
  const GlobalRouteWrapper({required this.router, super.key, super.child});

  final AppRouter router;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
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
