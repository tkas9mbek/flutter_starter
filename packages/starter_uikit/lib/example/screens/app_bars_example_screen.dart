import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/base_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/transparent_app_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class AppBarsExampleScreen extends StatefulWidget {
  const AppBarsExampleScreen({super.key});

  @override
  State<AppBarsExampleScreen> createState() => _AppBarsExampleScreenState();
}

class _AppBarsExampleScreenState extends State<AppBarsExampleScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(title: localizer.appBars),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            localizer.titleAppBar,
            style: textStyles.mediumBody16,
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TitleAppBar(
                  title: localizer.titleAppBar,
                  automaticallyImplyLeading: false,
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Screen content',
                      style: textStyles.regularBody14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            localizer.baseAppBar,
            style: textStyles.mediumBody16,
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                BaseAppBar(
                  height: 56,
                  child: Center(
                    child: Text(
                      localizer.customTitle,
                      style: textStyles.mediumBody16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Screen content',
                      style: textStyles.regularBody14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            localizer.transparentAppBar,
            style: textStyles.mediumBody16,
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TransparentAppBar(
                  title: localizer.transparentAppBar,
                  scrollController: _scrollController,
                  automaticallyImplyLeading: false,
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Screen content',
                      style: textStyles.regularBody14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
