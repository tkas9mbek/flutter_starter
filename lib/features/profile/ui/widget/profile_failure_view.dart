import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/profile/ui/bloc/profile_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

class ProfileFailureView extends StatelessWidget {
  const ProfileFailureView({
    required this.exception,
    super.key,
  });

  final AppException exception;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;
    final localizer = Localizer.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            localizer.failedToLoadProfile,
            style: textStyles.boldBody16,
          ),
          const SizedBox(height: 8),
          Text(
            exception.toString(),
            style: textStyles.regularBody14.copyWith(
              color: theme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppElevatedButton.medium(
            context: context,
            text: localizer.retry,
            onPressed: () => context.read<ProfileBloc>().add(
                  const ProfileEvent.requested(),
                ),
          ),
        ],
      ),
    );
  }
}
