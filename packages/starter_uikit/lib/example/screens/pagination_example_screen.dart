import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_uikit/l10n/generated/l10n.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/screen/paginated_list_view.dart';

/// **INTERNAL USE ONLY**: Demonstrates [PaginatedListView] driven by
/// [PaginatedData] and [BlocLoadState] — in an app these live in a bloc.
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

  Future<void> _loadNextPage() async {
    if (_status.isLoading) {
      return;
    }

    setState(() => _status = BlocLoadState.loading);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) {
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
  });

  @override
  Widget build(BuildContext context) {
    final localizer = UikitLocalizer.of(context);

    return Scaffold(
      appBar: TitleAppBar(
        title: localizer.paginationWidgets,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _reset),
        ],
      ),
      body: PaginatedListView<int>(
        data: _data,
        status: _status,
        onLoadMore: _loadNextPage,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separator: const SizedBox(height: 8),
        itemBuilder: (context, item, index) => Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            title: Text(localizer.paginationItem(item)),
            subtitle: _data.reachedEnd && index == _data.length - 1
                ? Text(localizer.endReached)
                : null,
          ),
        ),
      ),
    );
  }
}
