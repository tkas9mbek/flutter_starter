import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'profile_bloc.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loaded() = _LoadedProfileEvent;

  const factory ProfileEvent.logoutRequested() = _LogoutRequestedProfileEvent;
}

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState.initial() = _InitialProfileState;

  const factory ProfileState.loading() = _LoadingProfileState;

  const factory ProfileState.success(User user) = _SuccessProfileState;

  const factory ProfileState.failure(AppException exception) =
      _FailureProfileState;

  const factory ProfileState.loggingOut() = _LoggingOutProfileState;

  bool get isLoading => this is _LoadingProfileState;

  bool get isLoggingOut => this is _LoggingOutProfileState;
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;

  ProfileBloc(
    this._profileRepository,
    this._authRepository,
  ) : super(const ProfileState.initial()) {
    on<ProfileEvent>(
      (event, emit) => event.when(
        loaded: () => _onLoaded(emit),
        logoutRequested: () => _onLogoutRequested(emit),
      ),
    );
  }

  Future<void> _onLoaded(Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    try {
      final user = await _profileRepository.getUserProfile();
      emit(ProfileState.success(user));
    } on AppException catch (e) {
      emit(ProfileState.failure(e));
    }
  }

  Future<void> _onLogoutRequested(Emitter<ProfileState> emit) async {
    emit(const ProfileState.loggingOut());

    try {
      await _authRepository.logout();
    } on AppException catch (e) {
      emit(ProfileState.failure(e));
    }
  }
}
