import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/features/application/bloc/deep_link_bloc.dart';
import 'package:flutter_starter/features/application/widget/application_wrapper.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/theme/app_text_styles.dart';
import 'package:flutter_starter/theme/app_theme.dart';
import 'package:flutter_starter/theme/theme_data_from_theme.dart';
import 'package:flutter_starter/theme/theme_provider.dart';

final _router = AppRouter();

class Application extends StatelessWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeepLinkBloc>(
          lazy: false,
          create: (context) => getIt<DeepLinkBloc>()..add(),
        ),
      ],
      child: ThemeProvider(
        child: MaterialApp.router(
          locale: const Locale('ru'),
          themeMode: ThemeMode.light,
          theme: themeDataFromTheme(
            theme: AppTheme.light(),
            textStyles: AppTextStyles(),
          ),
          routerDelegate: _router.delegate(),
          routeInformationParser: _router.defaultRouteParser(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (context, child) => ApplicationWrapper(child: child!),
        ),
      ),
    );
  }
}
