import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/login/model/login_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'login_bloc.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted(LoginForm form) = _SubmittedLoginEvent;
}

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial() = _InitialLoginState;

  const factory LoginState.loading() = _LoadingLoginState;

  const factory LoginState.success() = _SuccessLoginState;

  const factory LoginState.failure(AppException exception) = _FailureLoginState;

  bool get isLoading => this is _LoadingLoginState;
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) => event.when(
        submitted: (form) async {
          emit(const LoginState.loading());

          try {
            await authRepository.login(
              phone: form.phone,
              password: form.password,
            );

            return emit(const LoginState.success());
          } on AppException catch (e) {
            return emit(LoginState.failure(e));
          }
        },
      ),
    );
  }
}
