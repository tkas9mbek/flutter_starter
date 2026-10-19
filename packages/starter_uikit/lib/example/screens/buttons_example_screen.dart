import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

/// **INTERNAL USE ONLY**: This screen is for UIKit testing and demonstration.
@visibleForTesting
@RoutePage()
class ButtonsExampleScreen extends StatefulWidget {
  const ButtonsExampleScreen({super.key});

  @override
  State<ButtonsExampleScreen> createState() => _ButtonsExampleScreenState();
}

class _ButtonsExampleScreenState extends State<ButtonsExampleScreen> {
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    setState(() => _isLoading = false);
  }

  void _showNotification() {
    NotificationSnackBar.show(
      context,
      NotificationSnackBar.success(
        text: UikitLocalizer.of(context).buttonPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.buttons),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: localizer.elevatedButton,
            children: [
              AppElevatedButton.big(
                context: context,
                text: localizer.elevatedButton,
                onPressed: _showNotification,
              ),
              AppElevatedButton.medium(
                context: context,
                text: localizer.elevatedButton,
                onPressed: _showNotification,
              ),
              AppElevatedButton.small(
                context: context,
                text: localizer.elevatedButton,
                onPressed: _showNotification,
              ),
            ],
          ),
          _Section(
            title: localizer.outlinedButton,
            children: [
              AppOutlinedButton.big(
                context: context,
                text: localizer.outlinedButton,
                onPressed: _showNotification,
              ),
              AppOutlinedButton.small(
                context: context,
                text: localizer.outlinedButton,
                onPressed: _showNotification,
              ),
            ],
          ),
          _Section(
            title: localizer.disabledButton,
            children: [
              AppElevatedButton.big(
                context: context,
                text: localizer.disabledButton,
                enabled: false,
              ),
              AppOutlinedButton.big(
                context: context,
                text: localizer.disabledButton,
                enabled: false,
              ),
            ],
          ),
          _Section(
            title: localizer.loadingButton,
            children: [
              AppElevatedButton.big(
                context: context,
                text: localizer.loadingButton,
                onPressed: _isLoading ? null : _simulateLoading,
                loading: _isLoading,
              ),
              AppOutlinedButton.big(
                context: context,
                text: localizer.loadingButton,
                onPressed: _isLoading ? null : _simulateLoading,
                loading: _isLoading,
              ),
            ],
          ),
          _DestructiveSection(onPressed: _showNotification),
        ],
      ),
    );
  }
}

class _DestructiveSection extends StatelessWidget {
  const _DestructiveSection({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    // Destructive actions reuse AppElevatedButton with the status fill.
    return _Section(
      title: 'Destructive',
      children: [
        AppElevatedButton(
          height: 48,
          width: double.infinity,
          text: 'Delete',
          textStyle: textStyles.mediumBody16,
          backgroundColor: theme.error,
          textColor: theme.onStatus,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

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
          for (final child in children) ...[
            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: child),
          ],
        ],
      ),
    );
  }
}
