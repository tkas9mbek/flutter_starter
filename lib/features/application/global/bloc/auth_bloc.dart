import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/model/auth_status.dart';

part 'auth_bloc.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialized() = _InitializedAuthEvent;

  const factory AuthEvent.logoutRequested() = _LogoutRequestedAuthEvent;

  const factory AuthEvent.loggedOut() = _LoggedOutAuthEvent;

  const factory AuthEvent.signedIn() = _StatusChangedAuthEvent;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = _UnknownAuthState;

  const factory AuthState.unauthenticated() = _UnauthenticatedAuthState;

  const factory AuthState.authenticated() = _AuthenticatedAuthState;

  const AuthState._();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  StreamSubscription<AuthStatus>? _authStatusSubscription;

  AuthBloc(this._authRepository) : super(const AuthState.unknown()) {
    _authStatusSubscription = _authRepository.status.listen((status) {
      if (status == AuthStatus.unauthenticated) {
        add(const AuthEvent.loggedOut());
      }

      if (status == AuthStatus.authenticated) {
        add(const AuthEvent.signedIn());
      }
    });

    on<AuthEvent>(
      (event, emit) => event.when(
        initialized: () async {
          try {
            await _authRepository.clearIfNotLaunchedBefore();

            final hasToken = await _authRepository.hasToken();

            if (hasToken) {
              return emit(const AuthState.authenticated());
            }

            return emit(const AuthState.unauthenticated());
          } catch (e) {
            return emit(const AuthState.unauthenticated());
          }
        },
        logoutRequested: _authRepository.logout,
        loggedOut: () => emit(const AuthState.unauthenticated()),
        signedIn: () => emit(const AuthState.authenticated()),
      ),
    );
  }

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
