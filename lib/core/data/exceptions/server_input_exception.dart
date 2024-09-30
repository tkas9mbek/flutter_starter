import 'package:flutter_starter/core/data/exceptions/server_exception.dart';
import 'package:flutter_starter/core/data/model/input_api_error.dart';

class ServerInputException extends ServerException {
  ServerInputException({
    required super.message,
    required super.statusCode,
    required this.inputApiErrors,
  });

  final List<InputApiError> inputApiErrors;
}
