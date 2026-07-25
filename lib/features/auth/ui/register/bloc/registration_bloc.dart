import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/register/model/registration_form.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'registration_bloc.freezed.dart';

@freezed
sealed class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.submitted(RegistrationForm form) =
      _SubmittedRegistrationEvent;
}

@freezed
sealed class RegistrationState with _$RegistrationState {
  const RegistrationState._();

  const factory RegistrationState.initial() = InitialRegistrationState;

  const factory RegistrationState.loading() = LoadingRegistrationState;

  const factory RegistrationState.success() = SuccessRegistrationState;

  const factory RegistrationState.failure(AppException exception) =
      FailureRegistrationState;

  bool get isLoading => this is LoadingRegistrationState;
}

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(this.authRepository)
    : super(const RegistrationState.initial()) {
    on<_SubmittedRegistrationEvent>(_onSubmitted);
  }

  final AuthRepository authRepository;

  Future<void> _onSubmitted(
    _SubmittedRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState.loading());

    try {
      await authRepository.register(
        name: event.form.name,
        phone: event.form.phone,
        password: event.form.password,
        birthday: event.form.birthday,
      );

      return emit(const RegistrationState.success());
    } on AppException catch (e) {
      return emit(RegistrationState.failure(e));
    }
  }
}
