import 'package:dio/dio.dart';
import 'package:flutter_starter/core/di/app_module.dart';
import 'package:flutter_starter/core/di/injection.dart';
import 'package:flutter_starter/features/post/core/data/post_api.dart';

class PostModule extends AppModule {
  @override
  void registerDependencies() {
    getIt.registerSingleton<PostApi>(
      PostApi(
        getIt.get<Dio>(),
        baseUrl: getIt.get<String>(instanceName: 'url'),
      ),
    );
  }
}
