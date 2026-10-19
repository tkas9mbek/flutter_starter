import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;

  const phone = '+79991234567';
  const otp = '1234';
  const exception = UnauthorizedException();

  setUp(() => repository = MockAuthRepository());

  test(
    'initial state is initial()',
    () => expect(OtpBloc(repository).state, const OtpState.initial()),
  );

  group('on submitted() event', () {
    const event = OtpEvent.submitted(phone: phone, otp: otp);

    blocTest<OtpBloc, OtpState>(
      'emits [loading, success] when the code is accepted',
      build: () {
        when(
          () => repository.verifyOtp(phone: phone, otp: otp),
        ).thenAnswer((_) async {});

        return OtpBloc(repository);
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const OtpState.loading(), const OtpState.success()],
      verify: (_) =>
          verify(() => repository.verifyOtp(phone: phone, otp: otp)).called(1),
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] when the code is refused',
      build: () {
        when(
          () => repository.verifyOtp(phone: phone, otp: otp),
        ).thenThrow(exception);

        return OtpBloc(repository);
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const OtpState.loading(),
        const OtpState.failure(exception),
      ],
    );
  });

  group('on resent() event', () {
    const event = OtpEvent.resent(phone: phone);

    blocTest<OtpBloc, OtpState>(
      'emits [loading, initial] once a new code is requested',
      build: () {
        when(
          () => repository.requestOtp(phone: phone),
        ).thenAnswer((_) async {});

        return OtpBloc(repository);
      },
      act: (bloc) => bloc.add(event),
      expect: () => [const OtpState.loading(), const OtpState.initial()],
      verify: (_) =>
          verify(() => repository.requestOtp(phone: phone)).called(1),
    );

    blocTest<OtpBloc, OtpState>(
      'clears a previous failure on a successful resend',
      build: () {
        when(
          () => repository.requestOtp(phone: phone),
        ).thenAnswer((_) async {});

        return OtpBloc(repository);
      },
      seed: () => const OtpState.failure(exception),
      act: (bloc) => bloc.add(event),
      expect: () => [const OtpState.loading(), const OtpState.initial()],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] when requesting a code throws',
      build: () {
        when(
          () => repository.requestOtp(phone: phone),
        ).thenThrow(const NoInternetException());

        return OtpBloc(repository);
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const OtpState.loading(),
        const OtpState.failure(NoInternetException()),
      ],
    );
  });
}
