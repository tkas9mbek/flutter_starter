import 'package:flutter/material.dart';
import 'package:starter/features/auth/ui/register/widget/registration_form_fields.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

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

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Localizer.of(context).signUp, style: textStyles.boldTitle20),
            const SizedBox(height: 24),
            const RegistrationFormFields(),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onLoginTap,
              child: Text(
                Localizer.of(context).haveAccount,
                style: textStyles.boldBody13.copyWith(color: theme.primary),
              ),
            ),
            const SizedBox(height: 32),
            AppElevatedButton.big(
              context: context,
              text: Localizer.of(context).toRegister,
              onPressed: onRegisterPressed,
            ),
          ],
        ),
      ),
    );
  }
}
