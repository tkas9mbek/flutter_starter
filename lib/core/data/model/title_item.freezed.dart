// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'title_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TitleItem _$TitleItemFromJson(Map<String, dynamic> json) {
  return _TitleItem.fromJson(json);
}

/// @nodoc
mixin _$TitleItem {
  String get title => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TitleItemCopyWith<TitleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TitleItemCopyWith<$Res> {
  factory $TitleItemCopyWith(TitleItem value, $Res Function(TitleItem) then) =
      _$TitleItemCopyWithImpl<$Res, TitleItem>;
  @useResult
  $Res call({String title, String? id});
}

/// @nodoc
class _$TitleItemCopyWithImpl<$Res, $Val extends TitleItem>
    implements $TitleItemCopyWith<$Res> {
  _$TitleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TitleItemImplCopyWith<$Res>
    implements $TitleItemCopyWith<$Res> {
  factory _$$TitleItemImplCopyWith(
          _$TitleItemImpl value, $Res Function(_$TitleItemImpl) then) =
      __$$TitleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? id});
}

/// @nodoc
class __$$TitleItemImplCopyWithImpl<$Res>
    extends _$TitleItemCopyWithImpl<$Res, _$TitleItemImpl>
    implements _$$TitleItemImplCopyWith<$Res> {
  __$$TitleItemImplCopyWithImpl(
      _$TitleItemImpl _value, $Res Function(_$TitleItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = freezed,
  }) {
    return _then(_$TitleItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TitleItemImpl implements _TitleItem {
  _$TitleItemImpl({required this.title, this.id});

  factory _$TitleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TitleItemImplFromJson(json);

  @override
  final String title;
  @override
  final String? id;

  @override
  String toString() {
    return 'TitleItem(title: $title, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TitleItemImplCopyWith<_$TitleItemImpl> get copyWith =>
      __$$TitleItemImplCopyWithImpl<_$TitleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TitleItemImplToJson(
      this,
    );
  }
}

abstract class _TitleItem implements TitleItem {
  factory _TitleItem({required final String title, final String? id}) =
      _$TitleItemImpl;

  factory _TitleItem.fromJson(Map<String, dynamic> json) =
      _$TitleItemImpl.fromJson;

  @override
  String get title;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$TitleItemImplCopyWith<_$TitleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
