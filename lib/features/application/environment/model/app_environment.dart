import 'package:equatable/equatable.dart';
import 'package:starter/core/consts/core_consts.dart';

class AppEnvironment extends Equatable {
  final String baseApiUrl;
  final String baseUrl;
  final String name;
  final bool showBanner;

  const AppEnvironment({
    required this.name,
    required this.baseApiUrl,
    required this.baseUrl,
    required this.showBanner,
  });

  factory AppEnvironment.prod() => const AppEnvironment(
        name: 'prod',
        baseApiUrl: CoreConsts.prodGeneralApiUrl,
        baseUrl: CoreConsts.prodBaseUrl,
        showBanner: false,
      );

  factory AppEnvironment.dev() => const AppEnvironment(
        name: 'dev',
        baseApiUrl: CoreConsts.devGeneralApiUrl,
        baseUrl: CoreConsts.devBaseUrl,
        showBanner: true,
      );

  factory AppEnvironment.fromName(String? name) {
    if (name == AppEnvironment.dev().name) {
      return AppEnvironment.dev();
    }

    return AppEnvironment.prod();
  }

  @override
  List<Object> get props => [baseUrl, name];
}
