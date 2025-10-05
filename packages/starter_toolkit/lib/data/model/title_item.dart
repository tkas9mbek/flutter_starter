import 'package:freezed_annotation/freezed_annotation.dart';

part 'title_item.freezed.dart';

part 'title_item.g.dart';

@freezed
class TitleItem with _$TitleItem {
  factory TitleItem({
    required String title,
    String? id,
  }) = _TitleItem;

  factory TitleItem.fromJson(Map<String, dynamic> json) =>
      _$TitleItemFromJson(json);
}
