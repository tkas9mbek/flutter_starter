import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';

/// Idle-state body: recent queries the user can re-run, or a hint when
/// there is no history yet.
class RecentQueriesList extends StatelessWidget {
  const RecentQueriesList({required this.queries, super.key});

  final List<String> queries;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    if (queries.isEmpty) {
      return EmptyInformationBody(text: localizer.startTypingToSearch);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localizer.recentSearches, style: textStyles.mediumBody14),
            TextButton(
              onPressed: () => context.read<TasksSearchBloc>().add(
                const TasksSearchEvent.recentCleared(),
              ),
              child: Text(localizer.clearAll),
            ),
          ],
        ),
        ...queries.map(
          (query) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgIcon(UiSvgIcons.clockTime, color: theme.textSecondary),
            title: Text(query, style: textStyles.regularBody14),
            onTap: () => context.read<TasksSearchBloc>().add(
              TasksSearchEvent.querySubmitted(query),
            ),
          ),
        ),
      ],
    );
  }
}
