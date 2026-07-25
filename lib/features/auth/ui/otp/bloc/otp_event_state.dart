part of 'otp_bloc.dart';

@freezed
sealed class OtpEvent with _$OtpEvent {
  const factory OtpEvent.submitted({
    required String phone,
    required String otp,
  }) = _SubmittedOtpEvent;

  const factory OtpEvent.resent({required String phone}) = _ResentOtpEvent;
}

@freezed
sealed class OtpState with _$OtpState {
  const OtpState._();

  const factory OtpState.initial() = InitialOtpState;

  const factory OtpState.loading() = LoadingOtpState;

  const factory OtpState.success() = SuccessOtpState;

  const factory OtpState.failure(AppException exception) = FailureOtpState;

  bool get isLoading => this is LoadingOtpState;
}
