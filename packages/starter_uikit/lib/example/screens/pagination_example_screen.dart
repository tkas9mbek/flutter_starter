import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/resources/resources.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/media/svg_icon.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/screen/paginated_list_view.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';

/// **INTERNAL USE ONLY**: Demonstrates [PaginatedListView] driven by
/// [PaginatedData] and [BlocLoadState] — in an app these live in a bloc.
/// The third page fails once to show the footer error row and its retry.
@visibleForTesting
@RoutePage()
class PaginationExampleScreen extends StatefulWidget {
  const PaginationExampleScreen({super.key});

  @override
  State<PaginationExampleScreen> createState() =>
      _PaginationExampleScreenState();
}

class _PaginationExampleScreenState extends State<PaginationExampleScreen> {
  static const _pageSize = 20;
  static const _pagesCount = 5;

  var _data = const PaginatedData<int>(
    page: 0,
    pagesCount: _pagesCount,
    items: [],
    itemsCount: _pageSize * _pagesCount,
    perPage: _pageSize,
  );
  var _status = BlocLoadState.initial;
  var _failedOnce = false;

  Future<void> _loadNextPage() async {
    if (_status.isLoading) {
      return;
    }

    setState(() => _status = BlocLoadState.loading);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) {
      return;
    }

    if (_data.nextPage == 3 && !_failedOnce) {
      setState(() {
        _failedOnce = true;
        _status = BlocLoadState.failure;
      });

      return;
    }

    final start = _data.length;
    final page = PaginatedData<int>(
      page: _data.nextPage,
      pagesCount: _pagesCount,
      items: List.generate(_pageSize, (i) => start + i + 1),
      itemsCount: _pageSize * _pagesCount,
      perPage: _pageSize,
    );

    setState(() {
      _data = _data.merge(page);
      _status = BlocLoadState.loaded;
    });
  }

  void _reset() => setState(() {
    _data = _data.copyWith(page: 0, items: []);
    _status = BlocLoadState.initial;
    _failedOnce = false;
  });

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);
    final theme = ThemeProvider.of(context).theme;

    return Scaffold(
      appBar: TitleAppBar(
        title: localizer.paginationWidgets,
        actions: [
          IconButton(
            icon: SvgIcon(UiSvgIcons.refreshArrow, color: theme.textPrimary),
            onPressed: _reset,
          ),
        ],
      ),
      body: PaginatedListView<int>(
        data: _data,
        status: _status,
        onLoadMore: _loadNextPage,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separator: const SizedBox(height: 8),
        errorWidget: FailureWidget.small(
          exception: const NoInternetException(),
          onRetry: _loadNextPage,
        ),
        itemBuilder: (context, item, index) => AppCard(
          child: AppListTile(
            title: localizer.paginationItem(item),
            subtitle: _data.reachedEnd && index == _data.length - 1
                ? localizer.endReached
                : null,
          ),
        ),
      ),
    );
  }
}
