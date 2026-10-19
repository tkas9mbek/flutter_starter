import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/register/widget/registration_form_fields.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

class RegistrationBody extends StatelessWidget {
  const RegistrationBody({
    required this.onLoginTap,
    required this.onRegisterPressed,
    super.key,
  });

  final VoidCallback onLoginTap;
  final VoidCallback onRegisterPressed;

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
            TitleSubtitle(title: localizer.signUp, textAlign: TextAlign.start),
            const SizedBox(height: 24),
            const RegistrationFormFields(),
            const SizedBox(height: 24),
            AppElevatedButton.big(
              context: context,
              text: localizer.toRegister,
              onPressed: onRegisterPressed,
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: onLoginTap,
                child: Text(
                  localizer.haveAccount,
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
