import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/router/app_router.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/list/widget/tasks_list_status_body.dart';
import 'package:starter/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/screen/multi_bloc_refresh_indicator.dart';
import 'package:starter_uikit/widgets/status/notification_snack_bar.dart';

@RoutePage()
class TasksListScreen extends StatelessWidget {
  const TasksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TasksListBloc>()..add(const TasksListEvent.requested()),
        ),
        BlocProvider(create: (context) => getIt<TaskDeleteBloc>()),
      ],
      child: const _TasksListView(),
    );
  }
}

class _TasksListView extends StatelessWidget {
  const _TasksListView();

  @override
  Widget build(BuildContext context) {
    final localizer = Localizer.of(context);
    final theme = ThemeProvider.of(context).theme;

    return BlocListener<TaskDeleteBloc, TaskDeleteState>(
      listener: (context, state) {
        if (state is SuccessTaskDeleteState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.success(
              text: localizer.taskDeletedSuccessfully,
            ),
          );
          context.read<TasksListBloc>().add(const TasksListEvent.requested());
        }

        if (state is FailureTaskDeleteState) {
          NotificationSnackBar.show(
            context,
            NotificationSnackBar.error(text: localizer.failedToDeleteTask),
          );
        }
      },
      child: Scaffold(
        appBar: TitleAppBar(
          title: localizer.tasks,
          actions: [
            IconButton(
              icon: const SvgIcon(UiSvgIcons.searchGlyph, size: 24),
              onPressed: () => context.router.push(const TasksSearchRoute()),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final created = await context.router.push<bool>(
              const TaskCreateRoute(),
            );

            if (created ?? false) {
              if (!context.mounted) {
                return;
              }
              context.read<TasksListBloc>().add(
                const TasksListEvent.requested(),
              );
            }
          },
          child: SvgIcon(UiSvgIcons.plusSign, size: 24, color: theme.onPrimary),
        ),
        body: MultiBlocRefreshIndicator(
          blocs: [context.read<TasksListBloc>()],
          onRefresh: () async => context.read<TasksListBloc>().add(
            const TasksListEvent.refreshed(),
          ),
          child: BlocBuilder<TasksListBloc, TasksListState>(
            builder: (context, state) => TasksListStatusBody(state: state),
          ),
        ),
      ),
    );
  }
}
