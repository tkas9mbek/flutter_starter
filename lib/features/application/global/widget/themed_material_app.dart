import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/application/global/widget/application_wrapper.dart';
import 'package:starter/features/application/global/widget/global_route_wrapper.dart';
import 'package:starter/features/settings/model/language_option.dart';
import 'package:starter/features/settings/model/theme_mode_option.dart';
import 'package:starter/features/settings/ui/theme/helpers/theme_mode_helper.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_text_styles.dart';
import 'package:starter_uikit/theme/app_theme.dart';
import 'package:starter_uikit/theme/theme_data_from_theme.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

/// The MaterialApp shell: resolves the active theme from the selected
/// language/theme options and wires routing, localization, and the global
/// route/app wrappers.
class ThemedMaterialApp extends StatelessWidget {
  const ThemedMaterialApp({
    required this.router,
    required this.language,
    required this.themeOption,
    super.key,
  });

  final AppRouter router;
  final LanguageOption language;
  final ThemeModeOption themeOption;

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeModeHelper.getThemeMode(themeOption);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final currentTheme = ThemeModeHelper.getCurrentTheme(
      themeOption,
      brightness,
    );

    return ThemeProvider(
      theme: currentTheme,
      child: MaterialApp.router(
        key: ValueKey('$language-$themeOption'),
        locale: language.locale,
        themeMode: themeMode,
        theme: themeDataFromTheme(
          theme: AppTheme.light(),
          textStyles: AppTextStyles(AppTheme.light()),
        ),
        darkTheme: themeDataFromTheme(
          theme: AppTheme.dark(),
          textStyles: AppTextStyles(AppTheme.dark()),
        ),
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
        localizationsDelegates: const [
          Localizer.delegate,
          UikitLocalizer.delegate,
          ToolkitLocalizer.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localizer.delegate.supportedLocales,
        builder: (context, child) => GlobalRouteWrapper(
          router: router,
          child: ApplicationWrapper(child: child!),
        ),
      ),
    );
  }
}
