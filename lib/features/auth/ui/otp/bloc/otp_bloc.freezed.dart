// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpEvent {

 String get phone;
/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpEventCopyWith<OtpEvent> get copyWith => _$OtpEventCopyWithImpl<OtpEvent>(this as OtpEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpEvent&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'OtpEvent(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $OtpEventCopyWith<$Res>  {
  factory $OtpEventCopyWith(OtpEvent value, $Res Function(OtpEvent) _then) = _$OtpEventCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$OtpEventCopyWithImpl<$Res>
    implements $OtpEventCopyWith<$Res> {
  _$OtpEventCopyWithImpl(this._self, this._then);

  final OtpEvent _self;
  final $Res Function(OtpEvent) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpEvent].
extension OtpEventPatterns on OtpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SubmittedOtpEvent value)?  submitted,TResult Function( _ResentOtpEvent value)?  resent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedOtpEvent() when submitted != null:
return submitted(_that);case _ResentOtpEvent() when resent != null:
return resent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SubmittedOtpEvent value)  submitted,required TResult Function( _ResentOtpEvent value)  resent,}){
final _that = this;
switch (_that) {
case _SubmittedOtpEvent():
return submitted(_that);case _ResentOtpEvent():
return resent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SubmittedOtpEvent value)?  submitted,TResult? Function( _ResentOtpEvent value)?  resent,}){
final _that = this;
switch (_that) {
case _SubmittedOtpEvent() when submitted != null:
return submitted(_that);case _ResentOtpEvent() when resent != null:
return resent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phone,  String otp)?  submitted,TResult Function( String phone)?  resent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedOtpEvent() when submitted != null:
return submitted(_that.phone,_that.otp);case _ResentOtpEvent() when resent != null:
return resent(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phone,  String otp)  submitted,required TResult Function( String phone)  resent,}) {final _that = this;
switch (_that) {
case _SubmittedOtpEvent():
return submitted(_that.phone,_that.otp);case _ResentOtpEvent():
return resent(_that.phone);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phone,  String otp)?  submitted,TResult? Function( String phone)?  resent,}) {final _that = this;
switch (_that) {
case _SubmittedOtpEvent() when submitted != null:
return submitted(_that.phone,_that.otp);case _ResentOtpEvent() when resent != null:
return resent(_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class _SubmittedOtpEvent implements OtpEvent {
  const _SubmittedOtpEvent({required this.phone, required this.otp});
  

@override final  String phone;
 final  String otp;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedOtpEventCopyWith<_SubmittedOtpEvent> get copyWith => __$SubmittedOtpEventCopyWithImpl<_SubmittedOtpEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedOtpEvent&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,phone,otp);

@override
String toString() {
  return 'OtpEvent.submitted(phone: $phone, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$SubmittedOtpEventCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory _$SubmittedOtpEventCopyWith(_SubmittedOtpEvent value, $Res Function(_SubmittedOtpEvent) _then) = __$SubmittedOtpEventCopyWithImpl;
@override @useResult
$Res call({
 String phone, String otp
});




}
/// @nodoc
class __$SubmittedOtpEventCopyWithImpl<$Res>
    implements _$SubmittedOtpEventCopyWith<$Res> {
  __$SubmittedOtpEventCopyWithImpl(this._self, this._then);

  final _SubmittedOtpEvent _self;
  final $Res Function(_SubmittedOtpEvent) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? otp = null,}) {
  return _then(_SubmittedOtpEvent(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResentOtpEvent implements OtpEvent {
  const _ResentOtpEvent({required this.phone});
  

@override final  String phone;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResentOtpEventCopyWith<_ResentOtpEvent> get copyWith => __$ResentOtpEventCopyWithImpl<_ResentOtpEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResentOtpEvent&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'OtpEvent.resent(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$ResentOtpEventCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory _$ResentOtpEventCopyWith(_ResentOtpEvent value, $Res Function(_ResentOtpEvent) _then) = __$ResentOtpEventCopyWithImpl;
@override @useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$ResentOtpEventCopyWithImpl<$Res>
    implements _$ResentOtpEventCopyWith<$Res> {
  __$ResentOtpEventCopyWithImpl(this._self, this._then);

  final _ResentOtpEvent _self;
  final $Res Function(_ResentOtpEvent) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_ResentOtpEvent(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState()';
}


}

/// @nodoc
class $OtpStateCopyWith<$Res>  {
$OtpStateCopyWith(OtpState _, $Res Function(OtpState) __);
}


/// Adds pattern-matching-related methods to [OtpState].
extension OtpStatePatterns on OtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialOtpState value)?  initial,TResult Function( LoadingOtpState value)?  loading,TResult Function( SuccessOtpState value)?  success,TResult Function( FailureOtpState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialOtpState() when initial != null:
return initial(_that);case LoadingOtpState() when loading != null:
return loading(_that);case SuccessOtpState() when success != null:
return success(_that);case FailureOtpState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialOtpState value)  initial,required TResult Function( LoadingOtpState value)  loading,required TResult Function( SuccessOtpState value)  success,required TResult Function( FailureOtpState value)  failure,}){
final _that = this;
switch (_that) {
case InitialOtpState():
return initial(_that);case LoadingOtpState():
return loading(_that);case SuccessOtpState():
return success(_that);case FailureOtpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialOtpState value)?  initial,TResult? Function( LoadingOtpState value)?  loading,TResult? Function( SuccessOtpState value)?  success,TResult? Function( FailureOtpState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialOtpState() when initial != null:
return initial(_that);case LoadingOtpState() when loading != null:
return loading(_that);case SuccessOtpState() when success != null:
return success(_that);case FailureOtpState() when failure != null:
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
case InitialOtpState() when initial != null:
return initial();case LoadingOtpState() when loading != null:
return loading();case SuccessOtpState() when success != null:
return success();case FailureOtpState() when failure != null:
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
case InitialOtpState():
return initial();case LoadingOtpState():
return loading();case SuccessOtpState():
return success();case FailureOtpState():
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
case InitialOtpState() when initial != null:
return initial();case LoadingOtpState() when loading != null:
return loading();case SuccessOtpState() when success != null:
return success();case FailureOtpState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialOtpState extends OtpState {
  const InitialOtpState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.initial()';
}


}

/// @nodoc
class $InitialOtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
$InitialOtpStateCopyWith(InitialOtpState _, $Res Function(InitialOtpState) __);
}
/// @nodoc
class _$InitialOtpStateCopyWithImpl<$Res>
    implements $InitialOtpStateCopyWith<$Res> {
  _$InitialOtpStateCopyWithImpl(this._self, this._then);

  final InitialOtpState _self;
  final $Res Function(InitialOtpState) _then;




}

/// @nodoc


class LoadingOtpState extends OtpState {
  const LoadingOtpState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.loading()';
}


}

/// @nodoc
class $LoadingOtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
$LoadingOtpStateCopyWith(LoadingOtpState _, $Res Function(LoadingOtpState) __);
}
/// @nodoc
class _$LoadingOtpStateCopyWithImpl<$Res>
    implements $LoadingOtpStateCopyWith<$Res> {
  _$LoadingOtpStateCopyWithImpl(this._self, this._then);

  final LoadingOtpState _self;
  final $Res Function(LoadingOtpState) _then;




}

/// @nodoc


class SuccessOtpState extends OtpState {
  const SuccessOtpState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpState.success()';
}


}

/// @nodoc
class $SuccessOtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
$SuccessOtpStateCopyWith(SuccessOtpState _, $Res Function(SuccessOtpState) __);
}
/// @nodoc
class _$SuccessOtpStateCopyWithImpl<$Res>
    implements $SuccessOtpStateCopyWith<$Res> {
  _$SuccessOtpStateCopyWithImpl(this._self, this._then);

  final SuccessOtpState _self;
  final $Res Function(SuccessOtpState) _then;




}

/// @nodoc


class FailureOtpState extends OtpState {
  const FailureOtpState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureOtpStateCopyWith<FailureOtpState> get copyWith => _$FailureOtpStateCopyWithImpl<FailureOtpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureOtpState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'OtpState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureOtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory $FailureOtpStateCopyWith(FailureOtpState value, $Res Function(FailureOtpState) _then) = _$FailureOtpStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureOtpStateCopyWithImpl<$Res>
    implements $FailureOtpStateCopyWith<$Res> {
  _$FailureOtpStateCopyWithImpl(this._self, this._then);

  final FailureOtpState _self;
  final $Res Function(FailureOtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureOtpState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
