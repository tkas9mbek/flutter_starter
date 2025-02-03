import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uikit/resources/resources.dart';
import 'package:uikit/theme/theme_provider.dart';
import 'package:uikit/widgets/app_bar/title_app_bar.dart';
import 'package:uikit/widgets/button/app_base_button.dart';
import 'package:uikit/widgets/notification/notification_snack_bar.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  bool _elevatedLoading = false;
  bool _outlinedLoading = false;
  bool _flatLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;

    return Scaffold(
      appBar: const TitleAppBar(title: 'Buttons'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              AppBaseButton.flat(
                theme: theme,
                text: 'Flat Button With Icon',
                icon: SvgPicture.asset(SvgIcons.call),
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              AppBaseButton.elevated(
                theme: theme,
                enabled: false,
                text: 'Disabled Elevated Button',
              ),
              const SizedBox(height: 24),
              AppBaseButton.elevated(
                theme: theme,
                text: 'Elevated Button',
                loading: _elevatedLoading,
                onPressed: () {
                  setState(() => _elevatedLoading = true);

                  Future.delayed(const Duration(seconds: 2), () {
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
              AppBaseButton.outLined(
                theme: theme,
                text: 'Outlined Button',
                loading: _outlinedLoading,
                onPressed: () {
                  setState(() => _outlinedLoading = true);

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() => _outlinedLoading = false);

                    NotificationSnackBar.showMessage(
                      context,
                      isSuccess: true,
                      message: 'Outlined Button Clicked',
                    );
                  });
                },
              ),
              const SizedBox(height: 24),
              AppBaseButton.flat(
                theme: theme,
                text: 'Flat Button',
                loading: _flatLoading,
                onPressed: () {
                  setState(() => _flatLoading = true);

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() => _flatLoading = false);

                    NotificationSnackBar.showMessage(
                      context,
                      isSuccess: true,
                      message: 'Flat Button Clicked',
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
