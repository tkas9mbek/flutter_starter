import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter/core/remote_config/domain/remote_config_repository.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';

part 'remote_configs_bloc.freezed.dart';
part 'remote_configs_event_state.dart';

/// Generic bloc that owns a single Firebase Remote Config entry of type [T].
///
/// Provide one per config you want to observe, e.g.
/// `RemoteConfigsBloc<RemoteGeneralSettings>`.
class RemoteConfigsBloc<T extends RemoteConfigEntry>
    extends Bloc<RemoteConfigsEvent, RemoteConfigsState<T>> {
  RemoteConfigsBloc(this._remoteConfigRepository)
    : super(RemoteConfigsState<T>.initial()) {
    on<_RequestedRemoteConfigsEvent>(_onRequested);
    on<_RefreshedRemoteConfigsEvent>(_onRefreshed);

    _updatesSubscription = _remoteConfigRepository.updates.listen(
      (_) => add(const RemoteConfigsEvent.refreshed()),
    );
  }

  final RemoteConfigRepository _remoteConfigRepository;
  StreamSubscription<void>? _updatesSubscription;

  Future<void> _onRequested(
    _RequestedRemoteConfigsEvent event,
    Emitter<RemoteConfigsState<T>> emit,
  ) => _load(emit);

  Future<void> _onRefreshed(
    _RefreshedRemoteConfigsEvent event,
    Emitter<RemoteConfigsState<T>> emit,
  ) => _load(emit);

  Future<void> _load(Emitter<RemoteConfigsState<T>> emit) async {
    emit(RemoteConfigsState<T>.loading());

    try {
      final config = await _remoteConfigRepository.get<T>();

      return emit(RemoteConfigsState<T>.success(config));
    } on AppException catch (e) {
      return emit(RemoteConfigsState<T>.failure(e));
    }
  }

  @override
  Future<void> close() async {
    await _updatesSubscription?.cancel();

    return super.close();
  }
}
