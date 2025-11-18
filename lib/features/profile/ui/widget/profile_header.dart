import 'package:flutter/material.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_uikit/theme/theme_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.primary,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
            style: textStyles.boldTitle20.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: textStyles.boldTitle20,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          user.phone,
          style: textStyles.regularBody14.copyWith(
            color: theme.textSecondary,
          ),
        ),
      ],
    );
  }
}
