import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@Freezed(fromJson: true, toJson: true)
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String phone,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
