import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter/features/profile/ui/bloc/profile_bloc.dart';
import 'package:starter/features/profile/ui/widget/profile_header.dart';
import 'package:starter/features/profile/ui/widget/profile_info_tile.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';

class ProfileSuccessView extends StatelessWidget {
  const ProfileSuccessView({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final localizer = Localizer.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ProfileHeader(user: user),
                const SizedBox(height: 24),
                ProfileInfoTile(
                  icon: Icons.cake_outlined,
                  label: localizer.birthday,
                  value: DateFormat('MMMM dd, yyyy').format(user.birthday),
                ),
                const SizedBox(height: 12),
                ProfileInfoTile(
                  icon: Icons.person_outline,
                  label: localizer.age,
                  value: localizer.yearsOld(
                    DateTime.now().year - user.birthday.year,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppOutlinedButton.medium(
            context: context,
            text: localizer.refresh,
            onPressed: () =>
                context.read<ProfileBloc>().add(const ProfileEvent.requested()),
          ),
          const SizedBox(height: 12),
          AppElevatedButton.big(
            context: context,
            text: localizer.toLogout,
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
          ),
        ],
      ),
    );
  }
}
