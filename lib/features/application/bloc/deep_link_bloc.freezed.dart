// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_link_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeepLinkEvent {
  Uri get link => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri link) received,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri link)? received,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri link)? received,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitedDeepLinkEvent value) received,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitedDeepLinkEvent value)? received,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitedDeepLinkEvent value)? received,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeepLinkEventCopyWith<DeepLinkEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeepLinkEventCopyWith<$Res> {
  factory $DeepLinkEventCopyWith(
          DeepLinkEvent value, $Res Function(DeepLinkEvent) then) =
      _$DeepLinkEventCopyWithImpl<$Res, DeepLinkEvent>;
  @useResult
  $Res call({Uri link});
}

/// @nodoc
class _$DeepLinkEventCopyWithImpl<$Res, $Val extends DeepLinkEvent>
    implements $DeepLinkEventCopyWith<$Res> {
  _$DeepLinkEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Uri,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitedDeepLinkEventImplCopyWith<$Res>
    implements $DeepLinkEventCopyWith<$Res> {
  factory _$$InitedDeepLinkEventImplCopyWith(_$InitedDeepLinkEventImpl value,
          $Res Function(_$InitedDeepLinkEventImpl) then) =
      __$$InitedDeepLinkEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri link});
}

/// @nodoc
class __$$InitedDeepLinkEventImplCopyWithImpl<$Res>
    extends _$DeepLinkEventCopyWithImpl<$Res, _$InitedDeepLinkEventImpl>
    implements _$$InitedDeepLinkEventImplCopyWith<$Res> {
  __$$InitedDeepLinkEventImplCopyWithImpl(_$InitedDeepLinkEventImpl _value,
      $Res Function(_$InitedDeepLinkEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$InitedDeepLinkEventImpl(
      null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$InitedDeepLinkEventImpl implements _InitedDeepLinkEvent {
  const _$InitedDeepLinkEventImpl(this.link);

  @override
  final Uri link;

  @override
  String toString() {
    return 'DeepLinkEvent.received(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitedDeepLinkEventImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitedDeepLinkEventImplCopyWith<_$InitedDeepLinkEventImpl> get copyWith =>
      __$$InitedDeepLinkEventImplCopyWithImpl<_$InitedDeepLinkEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri link) received,
  }) {
    return received(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri link)? received,
  }) {
    return received?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri link)? received,
    required TResult orElse(),
  }) {
    if (received != null) {
      return received(link);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitedDeepLinkEvent value) received,
  }) {
    return received(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitedDeepLinkEvent value)? received,
  }) {
    return received?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitedDeepLinkEvent value)? received,
    required TResult orElse(),
  }) {
    if (received != null) {
      return received(this);
    }
    return orElse();
  }
}

abstract class _InitedDeepLinkEvent implements DeepLinkEvent {
  const factory _InitedDeepLinkEvent(final Uri link) =
      _$InitedDeepLinkEventImpl;

  @override
  Uri get link;
  @override
  @JsonKey(ignore: true)
  _$$InitedDeepLinkEventImplCopyWith<_$InitedDeepLinkEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeepLinkState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialDeepLinkState value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialDeepLinkState value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialDeepLinkState value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeepLinkStateCopyWith<$Res> {
  factory $DeepLinkStateCopyWith(
          DeepLinkState value, $Res Function(DeepLinkState) then) =
      _$DeepLinkStateCopyWithImpl<$Res, DeepLinkState>;
}

/// @nodoc
class _$DeepLinkStateCopyWithImpl<$Res, $Val extends DeepLinkState>
    implements $DeepLinkStateCopyWith<$Res> {
  _$DeepLinkStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialDeepLinkStateImplCopyWith<$Res> {
  factory _$$InitialDeepLinkStateImplCopyWith(_$InitialDeepLinkStateImpl value,
          $Res Function(_$InitialDeepLinkStateImpl) then) =
      __$$InitialDeepLinkStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialDeepLinkStateImplCopyWithImpl<$Res>
    extends _$DeepLinkStateCopyWithImpl<$Res, _$InitialDeepLinkStateImpl>
    implements _$$InitialDeepLinkStateImplCopyWith<$Res> {
  __$$InitialDeepLinkStateImplCopyWithImpl(_$InitialDeepLinkStateImpl _value,
      $Res Function(_$InitialDeepLinkStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialDeepLinkStateImpl implements _InitialDeepLinkState {
  const _$InitialDeepLinkStateImpl();

  @override
  String toString() {
    return 'DeepLinkState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialDeepLinkStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialDeepLinkState value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialDeepLinkState value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialDeepLinkState value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialDeepLinkState implements DeepLinkState {
  const factory _InitialDeepLinkState() = _$InitialDeepLinkStateImpl;
}
