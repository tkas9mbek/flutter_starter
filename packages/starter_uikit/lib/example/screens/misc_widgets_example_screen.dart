import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/media/network_image_avatar.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/app_tap_area.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class MiscWidgetsExampleScreen extends StatelessWidget {
  const MiscWidgetsExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: TitleAppBar(title: localizer.miscWidgets),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Section(title: 'AppCard', child: _CardsDemo()),
          const _Section(
            title: 'GroupedRowsCard · AppListTile',
            child: _ListTilesDemo(),
          ),
          const _Section(title: 'AppTapArea', child: _TapAreaDemo()),
          const _Section(title: 'StatusPill', child: _StatusPillsDemo()),
          _Section(title: localizer.networkAvatar, child: const _AvatarsDemo()),
          _Section(
            title: localizer.thinDivider,
            child: AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (index, item) in ['Item 1', 'Item 2'].indexed) ...[
                    if (index != 0) ...[const ThinHorizontalDivider()],
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(item, style: textStyles.regularBody14),
                    ),
                  ],
                ],
              ),
            ),
          ),
          _Section(
            title: localizer.progressIndicator,
            child: const SizedBox(
              height: 64,
              child: CustomCircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardsDemo extends StatefulWidget {
  const _CardsDemo();

  @override
  State<_CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<_CardsDemo> {
  int _taps = 0;
  bool _selected = true;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final caption = textStyles.regularBody13.copyWith(
      color: theme.textSecondary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Text('Plain card', style: textStyles.mediumBody16),
        ),
        const SizedBox(height: 8),
        AppCard(
          padding: const EdgeInsets.all(16),
          onTap: () => setState(() => _taps++),
          child: Text('Tappable card · tapped $_taps×', style: caption),
        ),
        const SizedBox(height: 8),
        AppCard(
          padding: const EdgeInsets.all(16),
          selected: _selected,
          onTap: () => setState(() => _selected = !_selected),
          child: Text(
            _selected ? 'Selected card (tap to clear)' : 'Tap to select',
            style: textStyles.mediumBody16.copyWith(
              color: _selected ? theme.accent : theme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ListTilesDemo extends StatefulWidget {
  const _ListTilesDemo();

  @override
  State<_ListTilesDemo> createState() => _ListTilesDemoState();
}

class _ListTilesDemoState extends State<_ListTilesDemo> {
  bool _loading = false;
  bool _notifications = true;

  Future<void> _sync() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupedRowsCard(
      children: [
        AppListTile(
          icon: UiSvgIcons.personProfile,
          title: 'Profile',
          subtitle: 'Icon, subtitle and chevron',
          onTap: () {},
        ),
        AppListTile(
          icon: UiSvgIcons.globeLanguage,
          title: 'Language',
          value: 'English',
          onTap: () {},
        ),
        AppListTile(
          icon: UiSvgIcons.refreshArrow,
          title: 'Sync now',
          subtitle: 'Tap to show the loading state',
          loading: _loading,
          onTap: _sync,
        ),
        AppListTile(
          icon: UiSvgIcons.notificationBell,
          title: 'Notifications',
          trailing: Switch(
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
        ),
        const AppListTile(title: 'Version', value: '3.1.0'),
        AppListTile(
          icon: UiSvgIcons.trashDelete,
          title: 'Delete account',
          danger: true,
          onTap: () {},
        ),
      ],
    );
  }
}

class _TapAreaDemo extends StatefulWidget {
  const _TapAreaDemo();

  @override
  State<_TapAreaDemo> createState() => _TapAreaDemoState();
}

class _TapAreaDemoState extends State<_TapAreaDemo> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final caption = textStyles.regularBody13.copyWith(
      color: theme.textSecondary,
    );

    return Row(
      children: [
        AppTapArea(
          onTap: () => setState(() => _taps++),
          semanticLabel: 'Add',
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgIcon(UiSvgIcons.plusSign, color: theme.accent),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Icon-only button with a screen-reader label · tapped $_taps×',
            style: caption,
          ),
        ),
        const AppTapArea(
          child: Padding(padding: EdgeInsets.all(12), child: Text('Inert')),
        ),
      ],
    );
  }
}

class _StatusPillsDemo extends StatelessWidget {
  const _StatusPillsDemo();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        StatusPill(label: 'Success', color: theme.success),
        StatusPill(label: 'Error', color: theme.error),
        StatusPill(label: 'Warning', color: theme.warning),
        StatusPill(label: 'Info', color: theme.info),
      ],
    );
  }
}

class _AvatarsDemo extends StatelessWidget {
  const _AvatarsDemo();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        NetworkImageAvatar(
          imageUrl: 'https://i.pravatar.cc/150?img=1',
          size: 48,
        ),
        NetworkImageAvatar(
          imageUrl: 'https://i.pravatar.cc/150?img=2',
          size: 64,
        ),
        // An unreachable URL shows the initial-letter fallback.
        NetworkImageAvatar(imageUrl: 'invalid-url', name: 'Alex', size: 64),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

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
          child,
        ],
      ),
    );
  }
}
