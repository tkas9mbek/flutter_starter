import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/model/auth_status.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'auth_bloc.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialized() = _InitializedAuthEvent;

  const factory AuthEvent.logoutRequested() = _LogoutRequestedAuthEvent;

  const factory AuthEvent.loggedOut() = _LoggedOutAuthEvent;

  const factory AuthEvent.signedIn() = _SignedInAuthEvent;
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unknown() = UnknownAuthState;

  const factory AuthState.newUser() = NewUserAuthState;

  const factory AuthState.unauthenticated() = UnauthenticatedAuthState;

  const factory AuthState.authenticated() = AuthenticatedAuthState;

  const AuthState._();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState.unknown()) {
    _authStatusSubscription = _authRepository.status.listen((status) {
      if (status == AuthStatus.unauthenticated) {
        add(const AuthEvent.loggedOut());
      }

      if (status == AuthStatus.authenticated) {
        add(const AuthEvent.signedIn());
      }
    });

    on<_InitializedAuthEvent>(_onInitialized);
    on<_LogoutRequestedAuthEvent>((event, emit) => _authRepository.logout());
    on<_LoggedOutAuthEvent>(
      (event, emit) => emit(const AuthState.unauthenticated()),
    );
    on<_SignedInAuthEvent>(
      (event, emit) => emit(const AuthState.authenticated()),
    );
  }

  final AuthRepository _authRepository;
  StreamSubscription<AuthStatus>? _authStatusSubscription;

  Future<void> _onInitialized(
    _InitializedAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final launchedBefore = await _authRepository.clearIfNotLaunchedBefore();

      if (!launchedBefore) {
        return emit(const AuthState.newUser());
      }

      final hasToken = await _authRepository.hasToken();

      if (hasToken) {
        return emit(const AuthState.authenticated());
      }

      return emit(const AuthState.unauthenticated());
    } on AppException catch (exception) {
      // Fallback is deliberate: a failed local read must not block startup —
      // the user simply signs in again. Logged so storage corruption stays
      // visible instead of silently masquerading as "signed out".
      log('Startup auth check failed: ${exception.name}', name: 'AuthBloc');

      return emit(const AuthState.unauthenticated());
    }
  }

  @override
  Future<void> close() async {
    await _authStatusSubscription?.cancel();

    return super.close();
  }
}
