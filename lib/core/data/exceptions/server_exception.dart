import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/core/data/exceptions/app_exception.dart';
import 'package:flutter_starter/core/data/exceptions/auth_exception.dart';
import 'package:flutter_starter/core/data/exceptions/rights_exception.dart';
import 'package:flutter_starter/core/data/exceptions/server_input_exception.dart';
import 'package:flutter_starter/core/data/model/input_api_error.dart';
import 'package:flutter_starter/generated/l10n.dart';

class ServerException implements AppException {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final int? statusCode;
  final String? message;

  factory ServerException.concrete({
    int? statusCode,
    Response? response,
  }) {
    final responseData = response?.data;

    if (responseData is! Map<String, dynamic>) {
      return ServerException(
        message: null,
        statusCode: statusCode,
      );
    }

    final responseMessage = responseData['message'];

    if (responseData['errors'] != null) {
      return ServerInputException(
        message: responseMessage,
        statusCode: statusCode,
        inputApiErrors: (responseData['errors'] as List)
            .map((e) => InputApiError.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }

    if (statusCode == 403) {
      return const RightsException();
    }

    if (statusCode == 401) {
      return const AuthException();
    }

    return ServerException(
      message: responseMessage,
      statusCode: statusCode,
    );
  }

  @override
  bool get canRefresh => true;

  @override
  String getDescription(BuildContext context) {
    return message ?? S.of(context).errorMessageDefaultRequestError;
  }

  @override
  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);
}
