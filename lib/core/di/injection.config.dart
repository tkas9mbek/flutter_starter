// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_starter/core/data/repository_executor/deafult_repository_executor.dart'
    as _i1064;
import 'package:flutter_starter/core/data/repository_executor/repository_executor.dart'
    as _i1026;
import 'package:flutter_starter/features/application/bloc/deep_link_bloc.dart'
    as _i752;
import 'package:flutter_starter/features/post/core/data/post_api.dart' as _i575;
import 'package:flutter_starter/features/post/core/repository/post_repository.dart'
    as _i317;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i752.DeepLinkBloc>(() => _i752.DeepLinkBloc());
    gh.factory<_i1026.RepositoryExecutor>(
        () => _i1064.DefaultRepositoryExecutor());
    gh.lazySingleton<_i317.PostRepository>(() => _i317.PostRepository(
          gh<_i1026.RepositoryExecutor>(),
          gh<_i575.PostApi>(),
        ));
    return this;
  }
}
