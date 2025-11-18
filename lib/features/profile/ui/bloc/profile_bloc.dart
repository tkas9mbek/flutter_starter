import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'profile_bloc.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.requested() = _RequestedProfileEvent;
}

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState.initial() = _InitialProfileState;
  const factory ProfileState.loading() = _LoadingProfileState;
  const factory ProfileState.success(User user) = _SuccessProfileState;
  const factory ProfileState.failure(AppException exception) =
      _FailureProfileState;

  bool get isLoading => this is _LoadingProfileState;
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(const ProfileState.initial()) {
    on<_RequestedProfileEvent>(_onRequested);
  }

  Future<void> _onRequested(
    _RequestedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());

    try {
      final user = await _profileRepository.getUserProfile();

      return emit(ProfileState.success(user));
    } on AppException catch (e) {
      return emit(ProfileState.failure(e));
    }
  }
}
