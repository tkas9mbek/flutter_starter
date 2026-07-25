import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'login_bloc.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted(LoginForm form) = _SubmittedLoginEvent;
}

@freezed
sealed class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial() = InitialLoginState;

  const factory LoginState.loading() = LoadingLoginState;

  const factory LoginState.success() = SuccessLoginState;

  const factory LoginState.failure(AppException exception) = FailureLoginState;

  bool get isLoading => this is LoadingLoginState;
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authRepository) : super(const LoginState.initial()) {
    on<_SubmittedLoginEvent>(_onSubmitted);
  }

  final AuthRepository authRepository;

  Future<void> _onSubmitted(
    _SubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.loading());

    try {
      await authRepository.login(
        phone: event.form.phone,
        password: event.form.password,
      );

      return emit(const LoginState.success());
    } on AppException catch (e) {
      return emit(LoginState.failure(e));
    }
  }
}
