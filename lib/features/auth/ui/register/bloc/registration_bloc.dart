import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'registration_bloc.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.submitted(RegistrationForm form) =
      _SubmittedRegistrationEvent;
}

@freezed
class RegistrationState with _$RegistrationState {
  const RegistrationState._();

  const factory RegistrationState.initial() = _InitialRegistrationState;

  const factory RegistrationState.loading() = _LoadingRegistrationState;

  const factory RegistrationState.success() = _SuccessRegistrationState;

  const factory RegistrationState.failure(AppException exception) =
      _FailureRegistrationState;

  bool get isLoading => this is _LoadingRegistrationState;
}

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegistrationBloc(this.authRepository)
      : super(const RegistrationState.initial()) {
    on<RegistrationEvent>(
      (event, emit) => event.when(
        submitted: (form) async {
          emit(const RegistrationState.loading());

          try {
            await authRepository.login(
              phone: form.phone,
              password: form.password,
            );

            return emit(const RegistrationState.success());
          } on AppException catch (e) {
            return emit(RegistrationState.failure(e));
          }
        },
      ),
    );
  }
}
