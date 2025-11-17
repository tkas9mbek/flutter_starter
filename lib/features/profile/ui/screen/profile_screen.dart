import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/core/di/injection.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/profile/ui/bloc/profile_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(getIt<AuthRepository>())
        ..add(const ProfileEvent.loaded()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Scaffold(
      appBar: const TitleAppBar(
        title: 'Profile',
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initial')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (user) => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Card
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
                        // Avatar
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.primary,
                          child: Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                            style: textStyles.boldTitle20.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Name
                        Text(
                          user.name,
                          style: textStyles.boldTitle20,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Phone
                        Text(
                          user.phone,
                          style: textStyles.regularBody14.copyWith(
                            color: theme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Birthday Info
                        _InfoTile(
                          icon: Icons.cake_outlined,
                          label: 'Birthday',
                          value: DateFormat('MMMM dd, yyyy').format(user.birthday),
                        ),
                        const SizedBox(height: 12),

                        // Age Info
                        _InfoTile(
                          icon: Icons.person_outline,
                          label: 'Age',
                          value: '${DateTime.now().year - user.birthday.year} years old',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  AppElevatedButton.big(
                    context: context,
                    text: Localizer.of(context).toLogout,
                    onPressed: state.isLoggingOut
                        ? null
                        : () => context.read<ProfileBloc>().add(
                              const ProfileEvent.logoutRequested(),
                            ),
                  ),
                ],
              ),
            ),
            failure: (exception) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
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
                  ElevatedButton(
                    onPressed: () => context.read<ProfileBloc>().add(
                          const ProfileEvent.loaded(),
                        ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            loggingOut: () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Logging out...'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textStyles.regularBody13.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: textStyles.mediumBody14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
