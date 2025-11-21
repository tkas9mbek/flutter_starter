import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

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
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showNotification(String message) {
    NotificationSnackBar.showMessage(
      context,
      isSuccess: true,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.buttons),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizer.elevatedButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.elevatedButton,
              onPressed: () => _showNotification(localizer.buttonPressed),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.outlinedButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppOutlinedButton.big(
              context: context,
              text: localizer.outlinedButton,
              onPressed: () => _showNotification(localizer.buttonPressed),
            ),
            const SizedBox(height: 24),
            Text(
              localizer.disabledButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: 'Disabled',
              enabled: false,
            ),
            const SizedBox(height: 12),
            AppOutlinedButton.big(
              context: context,
              text: 'Disabled',
              enabled: false,
            ),
            const SizedBox(height: 24),
            Text(
              localizer.loadingButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AppElevatedButton.big(
              context: context,
              text: localizer.loadingButton,
              onPressed: _isLoading ? null : _simulateLoading,
              loading: _isLoading,
            ),
            const SizedBox(height: 12),
            AppOutlinedButton.big(
              context: context,
              text: localizer.loadingButton,
              onPressed: _isLoading ? null : _simulateLoading,
              loading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
