import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'user_bloc.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.requested() = _RequestedUserEvent;
  const factory UserEvent.updated(User user) = _UpdatedUserEvent;
}

@freezed
class UserState with _$UserState {
  const UserState._();

  const factory UserState.initial() = _InitialUserState;
  const factory UserState.loading() = _LoadingUserState;
  const factory UserState.success(User user) = _SuccessUserState;
  const factory UserState.failure(AppException exception) = _FailureUserState;

  bool get isLoading => this is _LoadingUserState;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final ProfileRepository _profileRepository;

  UserBloc(this._profileRepository) : super(const UserState.initial()) {
    on<_RequestedUserEvent>(_onRequested);
    on<_UpdatedUserEvent>(_onUpdated);
  }

  Future<void> _onRequested(
    _RequestedUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    try {
      final user = await _profileRepository.getUserProfile();

      return emit(UserState.success(user));
    } on AppException catch (e) {
      return emit(UserState.failure(e));
    }
  }

  Future<void> _onUpdated(
    _UpdatedUserEvent event,
    Emitter<UserState> emit,
  ) async {
    return emit(UserState.success(event.user));
  }
}
