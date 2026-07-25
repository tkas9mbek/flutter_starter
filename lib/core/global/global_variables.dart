import 'package:get_it/get_it.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';

final getIt = GetIt.instance;

/// Convenience for DI modules choosing between mock and remote data sources.
/// Outside `configs/` modules prefer injecting [AppEnvironment] explicitly.
bool get useMock => getIt<AppEnvironment>().useMock;
