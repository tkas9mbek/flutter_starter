import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_list_items.freezed.dart';

part 'paginated_list_items.g.dart';

@Freezed(genericArgumentFactories: true)
class PaginatedListItems<T> with _$PaginatedListItems<T> {
  factory PaginatedListItems({
    required int pageLimit,
    required int countItems,
    required int countPages,
    required List<T> elements,
  }) = _PaginatedListItems<T>;

  factory PaginatedListItems.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedListItemsFromJson<T>(json, fromJsonT);
}
