import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_value_item.freezed.dart';

part 'filter_value_item.g.dart';

@Freezed(genericArgumentFactories: true)
class FilterValueItem<T> with _$FilterValueItem<T> {
  factory FilterValueItem({
    required String id,
    required T value,
  }) = _FilterValueItem<T>;

  factory FilterValueItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$FilterValueItemFromJson(json, fromJsonT);
}
