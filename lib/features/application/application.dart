import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/switcher/bloc/environment_cubit.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/application/global/widget/themed_material_app.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/features/settings/ui/theme/bloc/theme_cubit.dart';

final _router = AppRouter();

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: [
        BlocProvider<EnvironmentCubit>(
          create: (context) => EnvironmentCubit(getIt<EnvironmentRepository>()),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(getIt<SettingsRepository>()),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(getIt<SettingsRepository>()),
        ),
        SingleChildBuilder(
          builder: (context, child) =>
              BlocBuilder<EnvironmentCubit, AppEnvironment>(
                builder: (context, env) =>
                    KeyedSubtree(key: ValueKey(env), child: child!),
              ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(getIt<AuthRepository>())
                ..add(const AuthEvent.initialized()),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageOption>(
        builder: (context, language) =>
            BlocBuilder<ThemeCubit, ThemeModeOption>(
              builder: (context, themeOption) => ThemedMaterialApp(
                router: _router,
                language: language,
                themeOption: themeOption,
              ),
            ),
      ),
    );
  }
}
