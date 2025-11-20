import 'package:flutter/material.dart';
import 'package:starter_uikit/example/screens/uikit_menu_screen.dart';
import 'package:starter_uikit/theme/app_theme.dart';

@visibleForTesting
class TestingApplication extends StatelessWidget {
  const TestingApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light().toThemeData(),
      darkTheme: AppTheme.dark().toThemeData(),
      home: const TestingUikitMenuScreen(),
    );
  }
}
