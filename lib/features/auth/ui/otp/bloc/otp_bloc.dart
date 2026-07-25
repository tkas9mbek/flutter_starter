import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'otp_bloc.freezed.dart';
part 'otp_event_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(this.authRepository) : super(const OtpState.initial()) {
    on<_SubmittedOtpEvent>(_onSubmitted);
    on<_ResentOtpEvent>(_onResent);
  }

  final AuthRepository authRepository;

  Future<void> _onSubmitted(
    _SubmittedOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpState.loading());

    try {
      await authRepository.verifyOtp(phone: event.phone, otp: event.otp);

      return emit(const OtpState.success());
    } on AppException catch (e) {
      return emit(OtpState.failure(e));
    }
  }

  Future<void> _onResent(_ResentOtpEvent event, Emitter<OtpState> emit) async {
    emit(const OtpState.loading());

    try {
      await authRepository.requestOtp(phone: event.phone);

      return emit(const OtpState.initial());
    } on AppException catch (e) {
      return emit(OtpState.failure(e));
    }
  }
}
