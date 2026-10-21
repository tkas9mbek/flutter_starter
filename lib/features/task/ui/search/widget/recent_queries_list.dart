import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';

/// Idle-state body: recent queries the user can re-run, or a hint when
/// there is no history yet.
class RecentQueriesList extends StatelessWidget {
  const RecentQueriesList({
    required this.queries,
    required this.onSelected,
    super.key,
  });

  final List<String> queries;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;
    final textStyles = ThemeProvider.of(context).textStyles;

    if (queries.isEmpty) {
      return EmptyInformationBody(text: localizer.startTypingToSearch);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  localizer.recentSearches,
                  style: textStyles.mediumBody13.copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.read<TasksSearchBloc>().add(
                  const TasksSearchEvent.recentCleared(),
                ),
                child: Text(
                  localizer.clearAll,
                  style: textStyles.mediumBody13.copyWith(color: theme.accent),
                ),
              ),
            ],
          ),
        ),
        GroupedRowsCard(
          children: [
            for (final query in queries) ...[
              AppListTile(
                icon: UiSvgIcons.clockTime,
                title: query,
                onTap: () => onSelected(query),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
