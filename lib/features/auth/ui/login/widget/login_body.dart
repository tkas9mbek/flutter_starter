import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/login/widget/login_form_fields.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

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
    final localizer = Localizer.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleSubtitle(title: localizer.login, textAlign: TextAlign.start),
            const SizedBox(height: 24),
            const LoginFormFields(),
            const SizedBox(height: 24),
            AppElevatedButton.big(
              context: context,
              loading: loading,
              text: localizer.toLogin,
              onPressed: onLoginPressed,
            ),
            const SizedBox(height: 12),
            AppOutlinedButton.big(
              context: context,
              text: localizer.signInWithCode,
              onPressed: onCodeSignInPressed,
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: onRegisterTap,
                child: Text(
                  localizer.haveNoAccount,
                  style: textStyles.mediumBody14.copyWith(color: theme.accent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
