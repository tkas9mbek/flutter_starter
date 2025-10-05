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
      listener: (context, state) => state.mapOrNull(
        unauthenticated: (_) => router.replaceAll([const LoginRoute()]),
        authenticated: (state) =>
            router.replaceAll([const AuthenticatedRouter()]),
      ),
      child: child,
    );
  }
}
