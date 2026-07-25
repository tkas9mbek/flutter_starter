import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/notifications/domain/push_notification_repository.dart';
import 'package:starter/core/notifications/domain/push_token_repository.dart';
import 'package:starter/core/notifications/model/push_message.dart';
import 'package:starter/core/notifications/push_navigation_resolver.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';

/// App-side glue for push notifications: requests permission, posts the token
/// once the user authenticates, and routes tapped pushes through the resolver.
///
/// Place high in the tree, below the [AuthBloc] provider.
class PushNotificationGate extends StatefulWidget {
  const PushNotificationGate({required this.child, super.key});

  final Widget child;

  @override
  State<PushNotificationGate> createState() => _PushNotificationGateState();
}

class _PushNotificationGateState extends State<PushNotificationGate> {
  late final PushNotificationRepository _pushRepository;
  late final PushTokenRepository _tokenRepository;
  StreamSubscription<PushMessage>? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _pushRepository = getIt<PushNotificationRepository>();
    _tokenRepository = getIt<PushTokenRepository>();

    unawaited(_pushRepository.requestPermission());

    getIt<PushNavigationResolver>().onOpened = _navigate;

    _messageSubscription = _pushRepository.messages
        .where((message) => message.wasOpened)
        .listen(_navigate);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(_handleInitialMessage()),
    );
  }

  Future<void> _handleInitialMessage() async {
    final message = await _pushRepository.getInitialMessage();

    if (message != null) {
      _navigate(message);
    }
  }

  void _navigate(PushMessage message) {
    log('Push opened: ${message.data}', name: 'PushNotificationGate');
  }

  @override
  void dispose() {
    unawaited(_messageSubscription?.cancel());
    getIt<PushNavigationResolver>().onOpened = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedAuthState) {
          unawaited(_tokenRepository.postCurrentToken());
        }
      },
      child: widget.child,
    );
  }
}
