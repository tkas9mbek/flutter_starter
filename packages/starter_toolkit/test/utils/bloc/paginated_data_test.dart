import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';
import 'package:starter_toolkit/data/model/title_item.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';

PaginatedData<String> _page(
  int page,
  List<String> items, {
  int pagesCount = 3,
  int itemsCount = 6,
}) => PaginatedData(
  page: page,
  pagesCount: pagesCount,
  items: items,
  itemsCount: itemsCount,
  perPage: 2,
);

void main() {
  test('fromApi reads a paginated payload with typed elements', () {
    final api = PaginatedListItems<TitleItem>.fromJson({
      'pageLimit': 2,
      'countItems': 3,
      'countPages': 2,
      'elements': [
        {'title': 'A', 'id': '1'},
        {'title': 'B', 'id': '2'},
      ],
    }, (json) => TitleItem.fromJson(json! as Map<String, dynamic>));

    final data = PaginatedData.fromApi(api);

    expect(data.page, 1);
    expect(data.pagesCount, 2);
    expect(data.itemsCount, 3);
    expect(data.items, [
      TitleItem(title: 'A', id: '1'),
      TitleItem(title: 'B', id: '2'),
    ]);
    expect(PaginatedData.fromApi(api, page: 2).page, 2);
  });

  test('paging getters follow page and pagesCount', () {
    final first = _page(1, ['a', 'b']);
    final last = _page(3, ['e']);

    expect(first.canLoadMore, isTrue);
    expect(first.reachedEnd, isFalse);
    expect(first.nextPage, 2);
    expect(first.length, 2);
    expect(first.isEmpty, isFalse);

    expect(last.canLoadMore, isFalse);
    expect(last.reachedEnd, isTrue);

    expect(_page(1, const [], pagesCount: 1, itemsCount: 0).isEmpty, isTrue);
  });

  test('merge appends the next page and takes its metadata', () {
    final merged = _page(1, [
      'a',
      'b',
    ]).merge(_page(2, ['c', 'd'], pagesCount: 4, itemsCount: 8));

    expect(merged.items, ['a', 'b', 'c', 'd']);
    expect(merged.page, 2);
    expect(merged.pagesCount, 4);
    expect(merged.itemsCount, 8);
    expect(merged.canLoadMore, isTrue);
  });

  test('add and addToStart insert an item and bump the total', () {
    final data = _page(1, ['b']);

    expect(data.add('c').items, ['b', 'c']);
    expect(data.add('c').itemsCount, 7);
    expect(data.addToStart('a').items, ['a', 'b']);
    expect(data.addToStart('a').itemsCount, 7);
    expect(data.items, ['b'], reason: 'the original stays unchanged');
  });

  test('equal content compares equal so blocs skip duplicate states', () {
    expect(_page(1, ['a']), _page(1, ['a']));
    expect(_page(1, ['a']), isNot(_page(2, ['a'])));
  });
}
