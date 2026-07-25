// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {

 LoginForm get form;
/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEventCopyWith<LoginEvent> get copyWith => _$LoginEventCopyWithImpl<LoginEvent>(this as LoginEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'LoginEvent(form: $form)';
}


}

/// @nodoc
abstract mixin class $LoginEventCopyWith<$Res>  {
  factory $LoginEventCopyWith(LoginEvent value, $Res Function(LoginEvent) _then) = _$LoginEventCopyWithImpl;
@useResult
$Res call({
 LoginForm form
});




}
/// @nodoc
class _$LoginEventCopyWithImpl<$Res>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._self, this._then);

  final LoginEvent _self;
  final $Res Function(LoginEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? form = null,}) {
  return _then(_self.copyWith(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as LoginForm,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SubmittedLoginEvent value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedLoginEvent() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SubmittedLoginEvent value)  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedLoginEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SubmittedLoginEvent value)?  submitted,}){
final _that = this;
switch (_that) {
case _SubmittedLoginEvent() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LoginForm form)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedLoginEvent() when submitted != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LoginForm form)  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedLoginEvent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LoginForm form)?  submitted,}) {final _that = this;
switch (_that) {
case _SubmittedLoginEvent() when submitted != null:
return submitted(_that.form);case _:
  return null;

}
}

}

/// @nodoc


class _SubmittedLoginEvent implements LoginEvent {
  const _SubmittedLoginEvent(this.form);
  

@override final  LoginForm form;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedLoginEventCopyWith<_SubmittedLoginEvent> get copyWith => __$SubmittedLoginEventCopyWithImpl<_SubmittedLoginEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedLoginEvent&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'LoginEvent.submitted(form: $form)';
}


}

/// @nodoc
abstract mixin class _$SubmittedLoginEventCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory _$SubmittedLoginEventCopyWith(_SubmittedLoginEvent value, $Res Function(_SubmittedLoginEvent) _then) = __$SubmittedLoginEventCopyWithImpl;
@override @useResult
$Res call({
 LoginForm form
});




}
/// @nodoc
class __$SubmittedLoginEventCopyWithImpl<$Res>
    implements _$SubmittedLoginEventCopyWith<$Res> {
  __$SubmittedLoginEventCopyWithImpl(this._self, this._then);

  final _SubmittedLoginEvent _self;
  final $Res Function(_SubmittedLoginEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = null,}) {
  return _then(_SubmittedLoginEvent(
null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as LoginForm,
  ));
}


}

/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialLoginState value)?  initial,TResult Function( LoadingLoginState value)?  loading,TResult Function( SuccessLoginState value)?  success,TResult Function( FailureLoginState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialLoginState() when initial != null:
return initial(_that);case LoadingLoginState() when loading != null:
return loading(_that);case SuccessLoginState() when success != null:
return success(_that);case FailureLoginState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialLoginState value)  initial,required TResult Function( LoadingLoginState value)  loading,required TResult Function( SuccessLoginState value)  success,required TResult Function( FailureLoginState value)  failure,}){
final _that = this;
switch (_that) {
case InitialLoginState():
return initial(_that);case LoadingLoginState():
return loading(_that);case SuccessLoginState():
return success(_that);case FailureLoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialLoginState value)?  initial,TResult? Function( LoadingLoginState value)?  loading,TResult? Function( SuccessLoginState value)?  success,TResult? Function( FailureLoginState value)?  failure,}){
final _that = this;
switch (_that) {
case InitialLoginState() when initial != null:
return initial(_that);case LoadingLoginState() when loading != null:
return loading(_that);case SuccessLoginState() when success != null:
return success(_that);case FailureLoginState() when failure != null:
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
case InitialLoginState() when initial != null:
return initial();case LoadingLoginState() when loading != null:
return loading();case SuccessLoginState() when success != null:
return success();case FailureLoginState() when failure != null:
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
case InitialLoginState():
return initial();case LoadingLoginState():
return loading();case SuccessLoginState():
return success();case FailureLoginState():
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
case InitialLoginState() when initial != null:
return initial();case LoadingLoginState() when loading != null:
return loading();case SuccessLoginState() when success != null:
return success();case FailureLoginState() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class InitialLoginState extends LoginState {
  const InitialLoginState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialLoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}

/// @nodoc
class $InitialLoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
$InitialLoginStateCopyWith(InitialLoginState _, $Res Function(InitialLoginState) __);
}
/// @nodoc
class _$InitialLoginStateCopyWithImpl<$Res>
    implements $InitialLoginStateCopyWith<$Res> {
  _$InitialLoginStateCopyWithImpl(this._self, this._then);

  final InitialLoginState _self;
  final $Res Function(InitialLoginState) _then;




}

/// @nodoc


class LoadingLoginState extends LoginState {
  const LoadingLoginState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingLoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}

/// @nodoc
class $LoadingLoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
$LoadingLoginStateCopyWith(LoadingLoginState _, $Res Function(LoadingLoginState) __);
}
/// @nodoc
class _$LoadingLoginStateCopyWithImpl<$Res>
    implements $LoadingLoginStateCopyWith<$Res> {
  _$LoadingLoginStateCopyWithImpl(this._self, this._then);

  final LoadingLoginState _self;
  final $Res Function(LoadingLoginState) _then;




}

/// @nodoc


class SuccessLoginState extends LoginState {
  const SuccessLoginState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessLoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.success()';
}


}

/// @nodoc
class $SuccessLoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
$SuccessLoginStateCopyWith(SuccessLoginState _, $Res Function(SuccessLoginState) __);
}
/// @nodoc
class _$SuccessLoginStateCopyWithImpl<$Res>
    implements $SuccessLoginStateCopyWith<$Res> {
  _$SuccessLoginStateCopyWithImpl(this._self, this._then);

  final SuccessLoginState _self;
  final $Res Function(SuccessLoginState) _then;




}

/// @nodoc


class FailureLoginState extends LoginState {
  const FailureLoginState(this.exception): super._();
  

 final  AppException exception;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureLoginStateCopyWith<FailureLoginState> get copyWith => _$FailureLoginStateCopyWithImpl<FailureLoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureLoginState&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'LoginState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureLoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $FailureLoginStateCopyWith(FailureLoginState value, $Res Function(FailureLoginState) _then) = _$FailureLoginStateCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FailureLoginStateCopyWithImpl<$Res>
    implements $FailureLoginStateCopyWith<$Res> {
  _$FailureLoginStateCopyWithImpl(this._self, this._then);

  final FailureLoginState _self;
  final $Res Function(FailureLoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FailureLoginState(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
