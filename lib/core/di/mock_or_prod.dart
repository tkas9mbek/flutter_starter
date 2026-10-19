import 'package:starter/core/global/global_variables.dart';

/// Factory for `registerFactory` / `registerLazySingleton` that builds the
/// mock twin under the mock environment and the production (API) implementation
/// otherwise.
T Function() mockOrProd<T extends Object>({
  required T Function() mock,
  required T Function() prod,
}) =>
    () => useMock ? mock() : prod();
