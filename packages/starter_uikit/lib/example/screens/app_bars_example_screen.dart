import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/app_radii.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/app_bar_back_button.dart';
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

    return Scaffold(
      appBar: TitleAppBar(title: localizer.appBars),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Preview(
            title: localizer.titleAppBar,
            appBar: TitleAppBar(
              title: localizer.titleAppBar,
              automaticallyImplyLeading: false,
            ),
          ),
          _Preview(
            title: localizer.baseAppBar,
            appBar: const BaseAppBar(height: 52, child: _BackButtonBar()),
          ),
          _Preview(
            title: localizer.transparentAppBar,
            appBar: TransparentAppBar(
              title: localizer.transparentAppBar,
              scrollController: _scrollController,
              automaticallyImplyLeading: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButtonBar extends StatelessWidget {
  const _BackButtonBar();

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;

    return Row(
      children: [
        const SizedBox(width: 4),
        AppBarBackButton(onTap: () {}),
        Expanded(
          child: Text(
            UikitLocalizer.of(context).customTitle,
            textAlign: TextAlign.center,
            style: textStyles.mediumTitle20,
          ),
        ),
        const SizedBox(width: 44),
      ],
    );
  }
}

/// Frames an app bar over a strip of page background, the way it sits on a
/// real screen: same plane, no shadow.
class _Preview extends StatelessWidget {
  const _Preview({required this.title, required this.appBar});

  final String title;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final borderRadius = BorderRadius.circular(AppRadii.md);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: textStyles.mediumBody13.copyWith(color: theme.textSecondary),
          ),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: borderRadius,
              border: Border.all(color: theme.border),
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Column(
                children: [
                  // A real app bar pads for the status bar; the preview
                  // sits mid-page, so that inset is dropped.
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: appBar,
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Screen content',
                        style: textStyles.regularBody14.copyWith(
                          color: theme.textTertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
