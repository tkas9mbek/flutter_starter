import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/task/model/task.dart';
import 'package:starter/features/task/ui/list/widget/task_list_item_tile.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/widgets/screen/paginated_list_view.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';

/// Paginated search results; requests the next page as the user scrolls.
class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    required this.data,
    required this.loadMoreState,
    super.key,
  });

  final PaginatedData<Task> data;
  final BlocLoadState loadMoreState;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return EmptyInformationBody(
        text: Localizer.of(context).noResultsFound,
      );
    }

    return PaginatedListView<Task>(
      data: data,
      status: loadMoreState,
      padding: const EdgeInsets.all(16),
      separator: const SizedBox(height: 8),
      onLoadMore: () => context.read<TasksSearchBloc>().add(
        const TasksSearchEvent.loadMoreRequested(),
      ),
      errorWidget: Center(
        child: TextButton(
          onPressed: () => context.read<TasksSearchBloc>().add(
            const TasksSearchEvent.loadMoreRequested(),
          ),
          child: Text(Localizer.of(context).retry),
        ),
      ),
      itemBuilder: (context, task, index) => Card(
        margin: EdgeInsets.zero,
        child: TaskListItemTile(task: task),
      ),
    );
  }
}
