import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_list_items.freezed.dart';

part 'api_list_items.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiListItems<T> with _$ApiListItems<T> {
  factory ApiListItems({
    required List<T> items,
  }) = _ApiListItems<T>;

  factory ApiListItems.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiListItemsFromJson<T>(json, fromJsonT);
}
