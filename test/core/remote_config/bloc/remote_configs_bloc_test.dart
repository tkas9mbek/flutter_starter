import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter/core/remote_config/data/mock/mock_remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/domain/remote_config_registry.dart';
import 'package:starter/core/remote_config/domain/remote_config_repository.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter/core/remote_config/model/remote_general_settings.dart';
import 'package:starter/core/remote_config/ui/bloc/remote_configs_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class _ThrowingRemoteConfigDataSource implements RemoteConfigDataSource {
  const _ThrowingRemoteConfigDataSource();

  @override
  Stream<void> get updates => const Stream<void>.empty();

  @override
  Future<T> get<T extends RemoteConfigEntry>() async =>
      throw const NoInternetException();
}

/// Wraps the real twin and lets the test push a server-side change.
class _UpdatingRemoteConfigDataSource implements RemoteConfigDataSource {
  _UpdatingRemoteConfigDataSource(this._delegate);

  final RemoteConfigDataSource _delegate;
  final _updates = StreamController<void>.broadcast();

  bool get hasListener => _updates.hasListener;

  void publish() => _updates.add(null);

  Future<void> close() => _updates.close();

  @override
  Stream<void> get updates => _updates.stream;

  @override
  Future<T> get<T extends RemoteConfigEntry>() => _delegate.get<T>();
}

void main() {
  const generalSettings = RemoteGeneralSettings(
    appVersion: AppVersion(
      minimal: AppVersionPlatform(ios: '1.0.0', android: '1.0.0'),
      current: AppVersionPlatform(ios: '2.0.0', android: '2.0.0'),
    ),
  );

  final twin = MockRemoteConfigDataSource(
    RemoteConfigRegistry([
      const RemoteConfigDescriptor<RemoteGeneralSettings>(
        key: 'general',
        fromJson: RemoteGeneralSettings.fromJson,
        defaultValue: generalSettings,
      ),
    ]),
    const MockNetworkBehavior.instant(),
  );

  RemoteConfigsBloc<RemoteGeneralSettings> buildBloc(
    RemoteConfigDataSource dataSource,
  ) => RemoteConfigsBloc<RemoteGeneralSettings>(
    RemoteConfigRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      dataSource,
    ),
  );

  test(
    'initial state is initial()',
    () => expect(
      buildBloc(twin).state,
      const RemoteConfigsState<RemoteGeneralSettings>.initial(),
    ),
  );

  blocTest<
    RemoteConfigsBloc<RemoteGeneralSettings>,
    RemoteConfigsState<RemoteGeneralSettings>
  >(
    'requested() emits [loading, success] with the registry value',
    build: () => buildBloc(twin),
    act: (bloc) => bloc.add(const RemoteConfigsEvent.requested()),
    expect: () => const [
      RemoteConfigsState<RemoteGeneralSettings>.loading(),
      RemoteConfigsState<RemoteGeneralSettings>.success(generalSettings),
    ],
  );

  blocTest<
    RemoteConfigsBloc<RemoteGeneralSettings>,
    RemoteConfigsState<RemoteGeneralSettings>
  >(
    'requested() emits [loading, failure] when the data source throws',
    build: () => buildBloc(const _ThrowingRemoteConfigDataSource()),
    act: (bloc) => bloc.add(const RemoteConfigsEvent.requested()),
    expect: () => const [
      RemoteConfigsState<RemoteGeneralSettings>.loading(),
      RemoteConfigsState<RemoteGeneralSettings>.failure(NoInternetException()),
    ],
  );

  group('server-side updates', () {
    late _UpdatingRemoteConfigDataSource dataSource;

    setUp(() => dataSource = _UpdatingRemoteConfigDataSource(twin));

    tearDown(() async => dataSource.close());

    blocTest<
      RemoteConfigsBloc<RemoteGeneralSettings>,
      RemoteConfigsState<RemoteGeneralSettings>
    >(
      'an update re-fetches the config',
      build: () => buildBloc(dataSource),
      act: (bloc) async {
        dataSource.publish();
        // The update hops through the broadcast stream before the bloc's
        // listener adds `refreshed()`; let it land before blocTest closes.
        await pumpEventQueue();
      },
      expect: () => const [
        RemoteConfigsState<RemoteGeneralSettings>.loading(),
        RemoteConfigsState<RemoteGeneralSettings>.success(generalSettings),
      ],
    );

    test('close stops listening for updates', () async {
      final bloc = buildBloc(dataSource);
      expect(dataSource.hasListener, isTrue);

      await bloc.close();

      expect(dataSource.hasListener, isFalse);
    });
  });

  test('isLoading is true only for loading()', () {
    expect(
      const RemoteConfigsState<RemoteGeneralSettings>.loading().isLoading,
      isTrue,
    );
    expect(
      const RemoteConfigsState<RemoteGeneralSettings>.success(
        generalSettings,
      ).isLoading,
      isFalse,
    );
  });
}
