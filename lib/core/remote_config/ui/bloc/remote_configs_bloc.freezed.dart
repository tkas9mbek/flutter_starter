// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_configs_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RemoteConfigsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteConfigsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsEvent()';
}


}

/// @nodoc
class $RemoteConfigsEventCopyWith<$Res>  {
$RemoteConfigsEventCopyWith(RemoteConfigsEvent _, $Res Function(RemoteConfigsEvent) __);
}


/// Adds pattern-matching-related methods to [RemoteConfigsEvent].
extension RemoteConfigsEventPatterns on RemoteConfigsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RequestedRemoteConfigsEvent value)?  requested,TResult Function( _RefreshedRemoteConfigsEvent value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent() when requested != null:
return requested(_that);case _RefreshedRemoteConfigsEvent() when refreshed != null:
return refreshed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RequestedRemoteConfigsEvent value)  requested,required TResult Function( _RefreshedRemoteConfigsEvent value)  refreshed,}){
final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent():
return requested(_that);case _RefreshedRemoteConfigsEvent():
return refreshed(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RequestedRemoteConfigsEvent value)?  requested,TResult? Function( _RefreshedRemoteConfigsEvent value)?  refreshed,}){
final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent() when requested != null:
return requested(_that);case _RefreshedRemoteConfigsEvent() when refreshed != null:
return refreshed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requested,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent() when requested != null:
return requested();case _RefreshedRemoteConfigsEvent() when refreshed != null:
return refreshed();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requested,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent():
return requested();case _RefreshedRemoteConfigsEvent():
return refreshed();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requested,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case _RequestedRemoteConfigsEvent() when requested != null:
return requested();case _RefreshedRemoteConfigsEvent() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class _RequestedRemoteConfigsEvent implements RemoteConfigsEvent {
  const _RequestedRemoteConfigsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestedRemoteConfigsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsEvent.requested()';
}


}

/// @nodoc
class _$RequestedRemoteConfigsEventCopyWith<$Res> implements $RemoteConfigsEventCopyWith<$Res> {
_$RequestedRemoteConfigsEventCopyWith(_RequestedRemoteConfigsEvent _, $Res Function(_RequestedRemoteConfigsEvent) __);
}
/// @nodoc
class __$RequestedRemoteConfigsEventCopyWithImpl<$Res>
    implements _$RequestedRemoteConfigsEventCopyWith<$Res> {
  __$RequestedRemoteConfigsEventCopyWithImpl(this._self, this._then);

  final _RequestedRemoteConfigsEvent _self;
  final $Res Function(_RequestedRemoteConfigsEvent) _then;




}

/// @nodoc


class _RefreshedRemoteConfigsEvent implements RemoteConfigsEvent {
  const _RefreshedRemoteConfigsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshedRemoteConfigsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsEvent.refreshed()';
}


}

/// @nodoc
class _$RefreshedRemoteConfigsEventCopyWith<$Res> implements $RemoteConfigsEventCopyWith<$Res> {
_$RefreshedRemoteConfigsEventCopyWith(_RefreshedRemoteConfigsEvent _, $Res Function(_RefreshedRemoteConfigsEvent) __);
}
/// @nodoc
class __$RefreshedRemoteConfigsEventCopyWithImpl<$Res>
    implements _$RefreshedRemoteConfigsEventCopyWith<$Res> {
  __$RefreshedRemoteConfigsEventCopyWithImpl(this._self, this._then);

  final _RefreshedRemoteConfigsEvent _self;
  final $Res Function(_RefreshedRemoteConfigsEvent) _then;




}

/// @nodoc
mixin _$RemoteConfigsState<T extends RemoteConfigEntry> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteConfigsState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsState<$T>()';
}


}

/// @nodoc
class $RemoteConfigsStateCopyWith<T extends RemoteConfigEntry,$Res>  {
$RemoteConfigsStateCopyWith(RemoteConfigsState<T> _, $Res Function(RemoteConfigsState<T>) __);
}


/// Adds pattern-matching-related methods to [RemoteConfigsState].
extension RemoteConfigsStatePatterns<T extends RemoteConfigEntry> on RemoteConfigsState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitialRemoteConfigsState<T> value)?  initial,TResult Function( _LoadingRemoteConfigsState<T> value)?  loading,TResult Function( _SuccessRemoteConfigsState<T> value)?  success,TResult Function( _FailureRemoteConfigsState<T> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialRemoteConfigsState() when initial != null:
return initial(_that);case _LoadingRemoteConfigsState() when loading != null:
return loading(_that);case _SuccessRemoteConfigsState() when success != null:
return success(_that);case _FailureRemoteConfigsState() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitialRemoteConfigsState<T> value)  initial,required TResult Function( _LoadingRemoteConfigsState<T> value)  loading,required TResult Function( _SuccessRemoteConfigsState<T> value)  success,required TResult Function( _FailureRemoteConfigsState<T> value)  failure,}){
final _that = this;
switch (_that) {
case _InitialRemoteConfigsState():
return initial(_that);case _LoadingRemoteConfigsState():
return loading(_that);case _SuccessRemoteConfigsState():
return success(_that);case _FailureRemoteConfigsState():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitialRemoteConfigsState<T> value)?  initial,TResult? Function( _LoadingRemoteConfigsState<T> value)?  loading,TResult? Function( _SuccessRemoteConfigsState<T> value)?  success,TResult? Function( _FailureRemoteConfigsState<T> value)?  failure,}){
final _that = this;
switch (_that) {
case _InitialRemoteConfigsState() when initial != null:
return initial(_that);case _LoadingRemoteConfigsState() when loading != null:
return loading(_that);case _SuccessRemoteConfigsState() when success != null:
return success(_that);case _FailureRemoteConfigsState() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T config)?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialRemoteConfigsState() when initial != null:
return initial();case _LoadingRemoteConfigsState() when loading != null:
return loading();case _SuccessRemoteConfigsState() when success != null:
return success(_that.config);case _FailureRemoteConfigsState() when failure != null:
return failure(_that.exception);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T config)  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case _InitialRemoteConfigsState():
return initial();case _LoadingRemoteConfigsState():
return loading();case _SuccessRemoteConfigsState():
return success(_that.config);case _FailureRemoteConfigsState():
return failure(_that.exception);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T config)?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case _InitialRemoteConfigsState() when initial != null:
return initial();case _LoadingRemoteConfigsState() when loading != null:
return loading();case _SuccessRemoteConfigsState() when success != null:
return success(_that.config);case _FailureRemoteConfigsState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class _InitialRemoteConfigsState<T extends RemoteConfigEntry> extends RemoteConfigsState<T> {
  const _InitialRemoteConfigsState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialRemoteConfigsState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsState<$T>.initial()';
}


}

/// @nodoc
class _$InitialRemoteConfigsStateCopyWith<T extends RemoteConfigEntry,$Res> implements $RemoteConfigsStateCopyWith<T, $Res> {
_$InitialRemoteConfigsStateCopyWith(_InitialRemoteConfigsState<T> _, $Res Function(_InitialRemoteConfigsState<T>) __);
}
/// @nodoc
class __$InitialRemoteConfigsStateCopyWithImpl<T extends RemoteConfigEntry,$Res>
    implements _$InitialRemoteConfigsStateCopyWith<T, $Res> {
  __$InitialRemoteConfigsStateCopyWithImpl(this._self, this._then);

  final _InitialRemoteConfigsState<T> _self;
  final $Res Function(_InitialRemoteConfigsState<T>) _then;




}

/// @nodoc


class _LoadingRemoteConfigsState<T extends RemoteConfigEntry> extends RemoteConfigsState<T> {
  const _LoadingRemoteConfigsState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingRemoteConfigsState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RemoteConfigsState<$T>.loading()';
}


}

/// @nodoc
class _$LoadingRemoteConfigsStateCopyWith<T extends RemoteConfigEntry,$Res> implements $RemoteConfigsStateCopyWith<T, $Res> {
_$LoadingRemoteConfigsStateCopyWith(_LoadingRemoteConfigsState<T> _, $Res Function(_LoadingRemoteConfigsState<T>) __);
}
/// @nodoc
class __$LoadingRemoteConfigsStateCopyWithImpl<T extends RemoteConfigEntry,$Res>
    implements _$LoadingRemoteConfigsStateCopyWith<T, $Res> {
  __$LoadingRemoteConfigsStateCopyWithImpl(this._self, this._then);

  final _LoadingRemoteConfigsState<T> _self;
  final $Res Function(_LoadingRemoteConfigsState<T>) _then;




}

/// @nodoc


class _SuccessRemoteConfigsState<T extends RemoteConfigEntry> extends RemoteConfigsState<T> {
  const _SuccessRemoteConfigsState(this.config): super._();
  

 final  T config;

/// Create a copy of RemoteConfigsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessRemoteConfigsStateCopyWith<T, _SuccessRemoteConfigsState<T>> get copyWith => __$SuccessRemoteConfigsStateCopyWithImpl<T, _SuccessRemoteConfigsState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuccessRemoteConfigsState<T>&&const DeepCollectionEquality().equals(other.config, config));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(config));

@override
String toString() {
  return 'RemoteConfigsState<$T>.success(config: $config)';
}


}

/// @nodoc
abstract mixin class _$SuccessRemoteConfigsStateCopyWith<T extends RemoteConfigEntry,$Res> implements $RemoteConfigsStateCopyWith<T, $Res> {
  factory _$SuccessRemoteConfigsStateCopyWith(_SuccessRemoteConfigsState<T> value, $Res Function(_SuccessRemoteConfigsState<T>) _then) = __$SuccessRemoteConfigsStateCopyWithImpl;
@useResult
$Res call({
 T config
});




}
/// @nodoc
class __$SuccessRemoteConfigsStateCopyWithImpl<T extends RemoteConfigEntry,$Res>
    implements _$SuccessRemoteConfigsStateCopyWith<T, $Res> {
  __$SuccessRemoteConfigsStateCopyWithImpl(this._self, this._then);

  final _SuccessRemoteConfigsState<T> _self;
  final $Res Function(_SuccessRemoteConfigsState<T>) _then;

/// Create a copy of RemoteConfigsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(_SuccessRemoteConfigsState<T>(
null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class _FailureRemoteConfigsState<T extends RemoteConfigEntry> extends RemoteConfigsState<T> {
  const _FailureRemoteConfigsState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of RemoteConfigsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureRemoteConfigsStateCopyWith<T, _FailureRemoteConfigsState<T>> get copyWith => __$FailureRemoteConfigsStateCopyWithImpl<T, _FailureRemoteConfigsState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FailureRemoteConfigsState<T>&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'RemoteConfigsState<$T>.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class _$FailureRemoteConfigsStateCopyWith<T extends RemoteConfigEntry,$Res> implements $RemoteConfigsStateCopyWith<T, $Res> {
  factory _$FailureRemoteConfigsStateCopyWith(_FailureRemoteConfigsState<T> value, $Res Function(_FailureRemoteConfigsState<T>) _then) = __$FailureRemoteConfigsStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class __$FailureRemoteConfigsStateCopyWithImpl<T extends RemoteConfigEntry,$Res>
    implements _$FailureRemoteConfigsStateCopyWith<T, $Res> {
  __$FailureRemoteConfigsStateCopyWithImpl(this._self, this._then);

  final _FailureRemoteConfigsState<T> _self;
  final $Res Function(_FailureRemoteConfigsState<T>) _then;

/// Create a copy of RemoteConfigsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(_FailureRemoteConfigsState<T>(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
