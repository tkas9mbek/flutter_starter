import 'package:starter_uikit/models/exception_ui_model.dart';
import 'package:starter_uikit/utils/mappers/exception_ui_mapper.dart';

/// Base decorator for wrapping exception mappers.
///
/// Allows selective override of specific exception mappings
/// while delegating others to the wrapped mapper.
///
/// Delegations are auto-generated from @ExceptionUiConfig annotations.
/// Run: dart run tool/generate_exception_mapper.dart
abstract class ExceptionUiMapperDecorator extends ExceptionUiMapper {
  final ExceptionUiMapper wrapped;

  ExceptionUiMapperDecorator(super.context, this.wrapped);

  // START GENERATED DELEGATIONS
  @override
  ExceptionUiModel mapNoInternet() => wrapped.mapNoInternet();

  @override
  ExceptionUiModel mapServer(int? statusCode, String? message) =>
      wrapped.mapServer(statusCode, message);

  @override
  ExceptionUiModel mapUnauthorized(String? message) =>
      wrapped.mapUnauthorized(message);

  @override
  ExceptionUiModel mapForbidden(String? message) =>
      wrapped.mapForbidden(message);

  @override
  ExceptionUiModel mapInternalServerError(String? message) =>
      wrapped.mapInternalServerError(message);

  @override
  ExceptionUiModel mapUnknown(Object error, StackTrace stackTrace) =>
      wrapped.mapUnknown(error, stackTrace);

  @override
  ExceptionUiModel mapDevelopment() => wrapped.mapDevelopment();

  @override
  ExceptionUiModel mapUrlLaunchFailed() => wrapped.mapUrlLaunchFailed();

  // END GENERATED DELEGATIONS
}
