part of 'remote_configs_bloc.dart';

@freezed
abstract class RemoteConfigsEvent with _$RemoteConfigsEvent {
  const factory RemoteConfigsEvent.requested() = _RequestedRemoteConfigsEvent;
  const factory RemoteConfigsEvent.refreshed() = _RefreshedRemoteConfigsEvent;
}

@freezed
abstract class RemoteConfigsState<T extends RemoteConfigEntry>
    with _$RemoteConfigsState<T> {
  const RemoteConfigsState._();

  const factory RemoteConfigsState.initial() = _InitialRemoteConfigsState<T>;
  const factory RemoteConfigsState.loading() = _LoadingRemoteConfigsState<T>;
  const factory RemoteConfigsState.success(T config) =
      _SuccessRemoteConfigsState<T>;
  const factory RemoteConfigsState.failure(AppException exception) =
      _FailureRemoteConfigsState<T>;

  bool get isLoading => this is _LoadingRemoteConfigsState<T>;
}
