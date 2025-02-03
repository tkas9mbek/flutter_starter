import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uikit/example/root_page.dart';
import 'package:uikit/generated/l10n.dart';
import 'package:uikit/theme/theme_data_from_theme.dart';
import 'package:uikit/theme/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (context) {
          final theme = ThemeProvider.of(context).theme;
          final textStyles = ThemeProvider.of(context).textStyles;

          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Flutter Demo',
            theme: themeDataFromTheme(
              theme: theme,
              textStyles: textStyles,
            ),
            home: const RootPage(),
          );
        },
      ),
    );
  }
}
