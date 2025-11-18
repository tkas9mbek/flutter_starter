import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';
import 'package:starter/features/application/environment/ui/bloc/environment_cubit.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/application/global/widget/application_wrapper.dart';
import 'package:starter/features/application/global/widget/global_route_wrapper.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/ui/language/bloc/language_cubit.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/theme/theme_data_from_theme.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

final _router = AppRouter();

class Application extends StatelessWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EnvironmentCubit>(
          create: (context) => EnvironmentCubit(
            getIt<EnvironmentRepository>(),
          ),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(
            getIt<SettingsRepository>(),
          ),
        ),
      ],
      child: BlocBuilder<EnvironmentCubit, AppEnvironment>(
        builder: (context, env) => MultiBlocProvider(
          key: ValueKey(env),
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                getIt<AuthRepository>(),
              )..add(const AuthEvent.initialized()),
            ),
          ],
          child: BlocBuilder<LanguageCubit, LanguageOption>(
            builder: (context, language) => ThemeProvider(
              child: MaterialApp.router(
                key: ValueKey(language),
                locale: language.locale,
                themeMode: ThemeMode.light,
                theme: themeDataFromTheme(
                  theme: AppTheme.light(),
                  textStyles: AppTextStyles(AppTheme.light()),
                ),
                darkTheme: themeDataFromTheme(
                  theme: AppTheme.dark(),
                  textStyles: AppTextStyles(AppTheme.dark()),
                ),
                routerDelegate: _router.delegate(),
                routeInformationParser: _router.defaultRouteParser(),
                localizationsDelegates: [
                  Localizer.delegate..load(language.locale),
                  UiLocalizer.delegate..load(language.locale),
                  ToolkitLocalizer.delegate..load(language.locale),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: Localizer.delegate.supportedLocales,
                builder: (context, child) => GlobalRouteWrapper(
                  router: _router,
                  child: ApplicationWrapper(child: child!),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
