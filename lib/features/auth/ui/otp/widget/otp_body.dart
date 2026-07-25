import 'package:flutter/material.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/form/otp_code_field.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({
    required this.destination,
    required this.fieldController,
    required this.error,
    required this.secondsLeft,
    required this.onCompleted,
    required this.onResend,
    required this.onSubmit,
    super.key,
  });

  final String destination;
  final OtpCodeFieldController fieldController;
  final String? error;
  final int secondsLeft;
  final ValueChanged<String> onCompleted;
  final VoidCallback onResend;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final localizer = Localizer.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          TitleSubtitle(
            title: localizer.otpTitle,
            subtitle: localizer.otpSubtitle(destination),
          ),
          const SizedBox(height: 32),
          OtpCodeField(
            controller: fieldController,
            hasError: error != null,
            onCompleted: onCompleted,
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(
              error!,
              style: textStyles.regularBody14.copyWith(color: theme.error),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: secondsLeft > 0 ? null : onResend,
              child: Text(
                secondsLeft > 0
                    ? localizer.otpResendIn(secondsLeft)
                    : localizer.otpResend,
              ),
            ),
          ),
          const Spacer(),
          AppElevatedButton.big(
            context: context,
            text: localizer.toContinue,
            onPressed: onSubmit,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
