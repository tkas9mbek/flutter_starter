import 'package:starter/core/remote_config/domain/remote_config_data_source.dart';
import 'package:starter/core/remote_config/model/remote_config_entry.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';
class RemoteConfigRepository {
  RemoteConfigRepository(
    this._repositoryExecutor,
    this._remoteConfigDataSource,
  );

  final RepositoryExecutor _repositoryExecutor;
  final RemoteConfigDataSource _remoteConfigDataSource;

  /// Emits whenever the remote config changes server-side, so observers can
  /// re-fetch. See [RemoteConfigDataSource.updates].
  Stream<void> get updates => _remoteConfigDataSource.updates;

  Future<T> get<T extends RemoteConfigEntry>() =>
      _repositoryExecutor.execute(_remoteConfigDataSource.get<T>);
}
