import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/model/user.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'user_bloc.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.requested() = _InitializedUserEvent;
}

@freezed
class UserState with _$UserState {
  const UserState._();

  const factory UserState.initial() = _InitialUserState;

  const factory UserState.success({
    required User user,
  }) = _SuccessUserState;

  const factory UserState.failure(AppException exception) = _FailureUserState;

  User? get user => maybeWhen(
        success: (user) => user,
        orElse: () => null,
      );
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository _authRepository;

  UserBloc(this._authRepository) : super(const UserState.initial()) {
    on<UserEvent>(
      (event, emit) => event.when(
        requested: () async {
          try {
            final user = await _authRepository.getUserProfile();

            return emit(UserState.success(user: user));
          } on AppException catch (e) {
            return emit(UserState.failure(e));
          }
        },
      ),
    );
  }
}
