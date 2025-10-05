import 'package:equatable/equatable.dart';
import 'package:starter_toolkit/data/model/paginated_list_items.dart';

class PaginatedData<T> extends Equatable {
  const PaginatedData({
    required this.page,
    required this.pagesCount,
    required this.items,
    required this.itemsCount,
    required this.perPage,
  });

  final int page;
  final int pagesCount;
  final int itemsCount;
  final int perPage;
  final List<T> items;

  factory PaginatedData.fromApi(
    PaginatedListItems<T> data, {
    int page = 1,
  }) =>
      PaginatedData(
        page: page,
        pagesCount: data.countPages,
        items: data.elements,
        itemsCount: data.countItems,
        perPage: data.countPages,
      );

  bool get isEmpty => items.isEmpty;

  bool get reachedEnd => page == pagesCount;

  bool get canLoadMore => page < pagesCount;

  int get length => items.length;

  int get nextPage => page + 1;

  @override
  List<Object> get props => [
        page,
        pagesCount,
        items,
        itemsCount,
        perPage,
      ];

  PaginatedData<T> copyWith({
    int? page,
    int? pagesCount,
    List<T>? items,
    int? itemsCount,
    int? perPage,
  }) =>
      PaginatedData(
        page: page ?? this.page,
        pagesCount: pagesCount ?? this.pagesCount,
        items: items ?? this.items,
        itemsCount: itemsCount ?? this.itemsCount,
        perPage: perPage ?? this.perPage,
      );

  PaginatedData<T> merge(PaginatedData<T> data) => copyWith(
        page: nextPage,
        perPage: data.perPage,
        pagesCount: data.pagesCount,
        itemsCount: data.itemsCount,
        items: [
          ...items,
          ...data.items,
        ],
      );

  PaginatedData<T> add(T item) => copyWith(
        items: [
          ...items,
          item,
        ],
        itemsCount: itemsCount + 1,
      );

  PaginatedData<T> addToStart(T item) => copyWith(
        items: [
          item,
          ...items,
        ],
        itemsCount: itemsCount + 1,
      );
}
