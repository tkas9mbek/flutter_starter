import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_uikit/example/cubit/theme_cubit.dart';
import 'package:starter_uikit/example/router/example_router.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// **INTERNAL USE ONLY**: Testing application for UIKit examples.
@visibleForTesting
class TestingApplication extends StatefulWidget {
  const TestingApplication({super.key});

  @override
  State<TestingApplication> createState() => _TestingApplicationState();
}

class _TestingApplicationState extends State<TestingApplication> {
  final _router = ExampleRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final lightTheme = AppTheme.light();
          final darkTheme = AppTheme.dark();
          final currentTheme =
              themeMode == ThemeMode.dark ? darkTheme : lightTheme;

          return ThemeProvider(
            theme: currentTheme,
            child: MaterialApp.router(
              routerConfig: _router.config(),
              theme: lightTheme.toThemeData(),
              darkTheme: darkTheme.toThemeData(),
              themeMode: themeMode,
              localizationsDelegates: const [
                UikitLocalizer.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: UikitLocalizer.delegate.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
