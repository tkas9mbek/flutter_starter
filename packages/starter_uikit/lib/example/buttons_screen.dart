import 'package:flutter/material.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/notification/notification_snack_bar.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  bool _elevatedLoading = false;
  bool _outlinedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(title: 'Buttons'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              AppElevatedButton.medium(
                context: context,
                enabled: false,
                text: 'Disabled Elevated Button',
              ),
              const SizedBox(height: 24),
              AppElevatedButton.medium(
                context: context,
                text: 'Elevated Button',
                loading: _elevatedLoading,
                onPressed: () {
                  setState(() => _elevatedLoading = true);

                  Future.delayed(const Duration(seconds: 2), () {
                    if (!mounted) return;

                    setState(() => _elevatedLoading = false);

                    NotificationSnackBar.showMessage(
                      context,
                      isSuccess: true,
                      message: 'Elevated Button Clicked',
                    );
                  });
                },
              ),
              const SizedBox(height: 24),
              AppOutlinedButton.medium(
                context: context,
                text: 'Outlined Button',
                loading: _outlinedLoading,
                onPressed: () {
                  setState(() => _outlinedLoading = true);

                  Future.delayed(const Duration(seconds: 2), () {
                    if (!mounted) return;

                    setState(() => _outlinedLoading = false);

                    NotificationSnackBar.showMessage(
                      context,
                      isSuccess: true,
                      message: 'Outlined Button Clicked',
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
