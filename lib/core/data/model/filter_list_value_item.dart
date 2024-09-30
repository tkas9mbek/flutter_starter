import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_list_value_item.freezed.dart';

part 'filter_list_value_item.g.dart';

@Freezed(genericArgumentFactories: true)
class FilterListValueItem<T> with _$FilterListValueItem<T> {
  factory FilterListValueItem({
    required String id,
    required List<T> value,
  }) = _FilterListValueItem<T>;

  factory FilterListValueItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$FilterListValueItemFromJson(json, fromJsonT);
}
