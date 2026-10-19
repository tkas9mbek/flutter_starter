import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starter/features/application/global/bloc/auth_bloc.dart';
import 'package:starter/features/application/root/widget/user_provider.dart';
import 'package:starter/features/profile/ui/overview/widget/profile_header.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context).user;
    final localizer = Localizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(title: localizer.profile),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          ProfileHeader(user: user),
          const SizedBox(height: 24),
          GroupedRowsCard(
            children: [
              AppListTile(
                icon: UiSvgIcons.calendarDates,
                title: localizer.birthday,
                value: DateFormat('MMMM dd, yyyy').format(user.birthday),
              ),
              AppListTile(
                icon: UiSvgIcons.personProfile,
                title: localizer.age,
                value: localizer.yearsOld(
                  DateTime.now().year - user.birthday.year,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GroupedRowsCard(
            children: [
              AppListTile(
                title: localizer.toLogout,
                danger: true,
                onTap: () => context.read<AuthBloc>().add(
                  const AuthEvent.logoutRequested(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
