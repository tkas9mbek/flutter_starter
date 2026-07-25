import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';
import 'package:starter/features/task/ui/search/widget/recent_queries_list.dart';
import 'package:starter/features/task/ui/search/widget/search_results_list.dart';
import 'package:starter/features/task/ui/search/widget/search_results_loading_skeleton.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/form/controller_text_field.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/unfocus_area.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class TasksSearchScreen extends StatelessWidget {
  const TasksSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TasksSearchBloc>()),
        BlocProvider(create: (context) => getIt<TaskDeleteBloc>()),
      ],
      child: const _TasksSearchView(),
    );
  }
}

class _TasksSearchView extends StatefulWidget {
  const _TasksSearchView();

  @override
  State<_TasksSearchView> createState() => _TasksSearchViewState();
}

class _TasksSearchViewState extends State<_TasksSearchView> {
  final _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);

    return BlocListener<TaskDeleteBloc, TaskDeleteState>(
      listener: (context, state) {
        if (state is SuccessTaskDeleteState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(
              text: localizer.taskDeletedSuccessfully,
            ),
          );
          context.read<TasksSearchBloc>().add(
            const TasksSearchEvent.refreshed(),
          );
        }
      },
      child: UnfocusArea(
        child: Scaffold(
          appBar: TitleAppBar(title: localizer.search),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ControllerTextField(
                  controller: _queryController,
                  hint: localizer.searchTasksHint,
                  autofocus: true,
                  hasClearButton: true,
                  textInputAction: TextInputAction.search,
                  prefix: const SvgIcon(UiSvgIcons.searchGlyph, size: 20),
                  onChanged: (query) => context.read<TasksSearchBloc>().add(
                    TasksSearchEvent.queryChanged(query),
                  ),
                  onSubmitted: (query) => context.read<TasksSearchBloc>().add(
                    TasksSearchEvent.querySubmitted(query),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<TasksSearchBloc, TasksSearchState>(
                  builder: (context, state) => switch (state.status) {
                    IdleTasksSearchStatus() => RecentQueriesList(
                      queries: state.recentQueries,
                    ),
                    LoadingTasksSearchStatus() =>
                      const SearchResultsLoadingSkeleton(),
                    SuggestionsTasksSearchStatus(:final tasks) =>
                      SearchResultsList(
                        data: PaginatedData(
                          page: 1,
                          pagesCount: 1,
                          items: tasks,
                          itemsCount: tasks.length,
                          perPage: tasks.length,
                        ),
                        loadMoreState: BlocLoadState.loaded,
                      ),
                    ResultsTasksSearchStatus(
                      :final data,
                      :final loadMoreState,
                    ) =>
                      SearchResultsList(
                        data: data,
                        loadMoreState: loadMoreState,
                      ),
                    FailureTasksSearchStatus(:final exception) =>
                      FailureWidget.large(
                        exception: exception,
                        onRetry: () => context.read<TasksSearchBloc>().add(
                          const TasksSearchEvent.refreshed(),
                        ),
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
