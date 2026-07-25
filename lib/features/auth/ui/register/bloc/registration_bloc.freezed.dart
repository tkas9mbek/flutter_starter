// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationEvent {

 RegistrationForm get form;
/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationEventCopyWith<RegistrationEvent> get copyWith => _$RegistrationEventCopyWithImpl<RegistrationEvent>(this as RegistrationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'RegistrationEvent(form: $form)';
}


}

/// @nodoc
abstract mixin class $RegistrationEventCopyWith<$Res>  {
  factory $RegistrationEventCopyWith(RegistrationEvent value, $Res Function(RegistrationEvent) _then) = _$RegistrationEventCopyWithImpl;
@useResult
$Res call({
 RegistrationForm form
});




}
/// @nodoc
class _$RegistrationEventCopyWithImpl<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  _$RegistrationEventCopyWithImpl(this._self, this._then);

  final RegistrationEvent _self;
  final $Res Function(RegistrationEvent) _then;

/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? form = null,}) {
  return _then(_self.copyWith(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as RegistrationForm,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationEvent].
extension RegistrationEventPatterns on RegistrationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SubmittedRegistrationEvent value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SubmittedRegistrationEvent value)  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SubmittedRegistrationEvent value)?  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RegistrationForm form)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent() when submitted != null:
return submitted(_that.form);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RegistrationForm form)  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent():
return submitted(_that.form);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RegistrationForm form)?  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedRegistrationEvent() when submitted != null:
return submitted(_that.form);case _:
  return null;

}
}

}

/// @nodoc


class _SubmittedRegistrationEvent implements RegistrationEvent {
  const _SubmittedRegistrationEvent(this.form);
  

@override final  RegistrationForm form;

/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedRegistrationEventCopyWith<_SubmittedRegistrationEvent> get copyWith => __$SubmittedRegistrationEventCopyWithImpl<_SubmittedRegistrationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedRegistrationEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'RegistrationEvent.submitted(form: $form)';
}


}

/// @nodoc
abstract mixin class _$SubmittedRegistrationEventCopyWith<$Res> implements $RegistrationEventCopyWith<$Res> {
  factory _$SubmittedRegistrationEventCopyWith(_SubmittedRegistrationEvent value, $Res Function(_SubmittedRegistrationEvent) _then) = __$SubmittedRegistrationEventCopyWithImpl;
@override @useResult
$Res call({
 RegistrationForm form
});




}
/// @nodoc
class __$SubmittedRegistrationEventCopyWithImpl<$Res>
    implements _$SubmittedRegistrationEventCopyWith<$Res> {
  __$SubmittedRegistrationEventCopyWithImpl(this._self, this._then);

  final _SubmittedRegistrationEvent _self;
  final $Res Function(_SubmittedRegistrationEvent) _then;

/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = null,}) {
  return _then(_SubmittedRegistrationEvent(
null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as RegistrationForm,
  ));
}


}

/// @nodoc
mixin _$RegistrationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState()';
}


}

/// @nodoc
class $RegistrationStateCopyWith<$Res>  {
$RegistrationStateCopyWith(RegistrationState _, $Res Function(RegistrationState) __);
}


/// Adds pattern-matching-related methods to [RegistrationState].
extension RegistrationStatePatterns on RegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialRegistrationState value)?  initial,TResult Function( LoadingRegistrationState value)?  loading,TResult Function( SuccessRegistrationState value)?  success,TResult Function( FailureRegistrationState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialRegistrationState() when initial != null:
return initial(_that);case LoadingRegistrationState() when loading != null:
return loading(_that);case SuccessRegistrationState() when success != null:
return success(_that);case FailureRegistrationState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialRegistrationState value)  initial,required TResult Function( LoadingRegistrationState value)  loading,required TResult Function( SuccessRegistrationState value)  success,required TResult Function( FailureRegistrationState value)  failure,}){
final _that = this;
switch (_that) {
case InitialRegistrationState():
return initial(_that);case LoadingRegistrationState():
return loading(_that);case SuccessRegistrationState():
return success(_that);case FailureRegistrationState():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialRegistrationState value)?  initial,TResult? Function( LoadingRegistrationState value)?  loading,TResult? Function( SuccessRegistrationState value)?  success,TResult? Function( FailureRegistrationState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialRegistrationState() when initial != null:
return initial(_that);case LoadingRegistrationState() when loading != null:
return loading(_that);case SuccessRegistrationState() when success != null:
return success(_that);case FailureRegistrationState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialRegistrationState() when initial != null:
return initial();case LoadingRegistrationState() when loading != null:
return loading();case SuccessRegistrationState() when success != null:
return success();case FailureRegistrationState() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case InitialRegistrationState():
return initial();case LoadingRegistrationState():
return loading();case SuccessRegistrationState():
return success();case FailureRegistrationState():
return failure(_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case InitialRegistrationState() when initial != null:
return initial();case LoadingRegistrationState() when loading != null:
return loading();case SuccessRegistrationState() when success != null:
return success();case FailureRegistrationState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialRegistrationState extends RegistrationState {
  const InitialRegistrationState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialRegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.initial()';
}


}

/// @nodoc
class $InitialRegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
$InitialRegistrationStateCopyWith(InitialRegistrationState _, $Res Function(InitialRegistrationState) __);
}
/// @nodoc
class _$InitialRegistrationStateCopyWithImpl<$Res>
    implements $InitialRegistrationStateCopyWith<$Res> {
  _$InitialRegistrationStateCopyWithImpl(this._self, this._then);

  final InitialRegistrationState _self;
  final $Res Function(InitialRegistrationState) _then;




}

/// @nodoc


class LoadingRegistrationState extends RegistrationState {
  const LoadingRegistrationState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingRegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.loading()';
}


}

/// @nodoc
class $LoadingRegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
$LoadingRegistrationStateCopyWith(LoadingRegistrationState _, $Res Function(LoadingRegistrationState) __);
}
/// @nodoc
class _$LoadingRegistrationStateCopyWithImpl<$Res>
    implements $LoadingRegistrationStateCopyWith<$Res> {
  _$LoadingRegistrationStateCopyWithImpl(this._self, this._then);

  final LoadingRegistrationState _self;
  final $Res Function(LoadingRegistrationState) _then;




}

/// @nodoc


class SuccessRegistrationState extends RegistrationState {
  const SuccessRegistrationState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessRegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.success()';
}


}

/// @nodoc
class $SuccessRegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
$SuccessRegistrationStateCopyWith(SuccessRegistrationState _, $Res Function(SuccessRegistrationState) __);
}
/// @nodoc
class _$SuccessRegistrationStateCopyWithImpl<$Res>
    implements $SuccessRegistrationStateCopyWith<$Res> {
  _$SuccessRegistrationStateCopyWithImpl(this._self, this._then);

  final SuccessRegistrationState _self;
  final $Res Function(SuccessRegistrationState) _then;




}

/// @nodoc


class FailureRegistrationState extends RegistrationState {
  const FailureRegistrationState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureRegistrationStateCopyWith<FailureRegistrationState> get copyWith => _$FailureRegistrationStateCopyWithImpl<FailureRegistrationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureRegistrationState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'RegistrationState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureRegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory $FailureRegistrationStateCopyWith(FailureRegistrationState value, $Res Function(FailureRegistrationState) _then) = _$FailureRegistrationStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureRegistrationStateCopyWithImpl<$Res>
    implements $FailureRegistrationStateCopyWith<$Res> {
  _$FailureRegistrationStateCopyWithImpl(this._self, this._then);

  final FailureRegistrationState _self;
  final $Res Function(FailureRegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureRegistrationState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
