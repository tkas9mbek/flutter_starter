import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/login/widget/login_form_fields.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    required this.loading,
    required this.onRegisterTap,
    required this.onLoginPressed,
    required this.onCodeSignInPressed,
    super.key,
  });

  final bool loading;
  final VoidCallback onRegisterTap;
  final VoidCallback onLoginPressed;
  final VoidCallback onCodeSignInPressed;

  @override
  Widget build(BuildContext context) {
    final textStyles = ThemeProvider.of(context).textStyles;
    final theme = ThemeProvider.of(context).theme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginFormFields(),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onRegisterTap,
              child: Text(
                Localizer.of(context).haveNoAccount,
                style: textStyles.boldBody13.copyWith(color: theme.primary),
              ),
            ),
            const SizedBox(height: 32),
            AppElevatedButton.big(
              context: context,
              loading: loading,
              text: Localizer.of(context).toLogin,
              onPressed: onLoginPressed,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onCodeSignInPressed,
              child: Text(Localizer.of(context).signInWithCode),
            ),
          ],
        ),
      ),
    );
  }
}
