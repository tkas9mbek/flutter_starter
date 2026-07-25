import 'package:equatable/equatable.dart';
import 'package:starter/core/global/core_consts.dart';

class AppEnvironment extends Equatable {
  const AppEnvironment({
    required this.name,
    required this.baseApiUrl,
    required this.baseUrl,
    required this.showBanner,
    required this.useMock,
  });

  factory AppEnvironment.prod() => const AppEnvironment(
    name: 'prod',
    baseApiUrl: CoreConsts.prodGeneralApiUrl,
    baseUrl: CoreConsts.prodBaseUrl,
    showBanner: false,
    useMock: false,
  );

  factory AppEnvironment.dev() => const AppEnvironment(
    name: 'dev',
    baseApiUrl: CoreConsts.devGeneralApiUrl,
    baseUrl: CoreConsts.devBaseUrl,
    showBanner: true,
    useMock: false,
  );

  factory AppEnvironment.mock() => const AppEnvironment(
    name: 'mock',
    baseApiUrl: CoreConsts.devGeneralApiUrl,
    baseUrl: CoreConsts.devBaseUrl,
    showBanner: true,
    useMock: true,
  );

  factory AppEnvironment.fromName(String? name) {
    if (name == AppEnvironment.dev().name) {
      return AppEnvironment.dev();
    }

    if (name == AppEnvironment.prod().name) {
      return AppEnvironment.prod();
    }

    return AppEnvironment.mock();
  }

  final String baseApiUrl;
  final String baseUrl;
  final String name;
  final bool showBanner;
  final bool useMock;

  @override
  List<Object> get props => [name, baseUrl, baseApiUrl, showBanner, useMock];
}
