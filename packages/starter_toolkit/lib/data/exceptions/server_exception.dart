import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/exceptions/auth_exception.dart';
import 'package:starter_toolkit/data/exceptions/rights_exception.dart';
import 'package:starter_toolkit/data/exceptions/server_500_exception.dart';
import 'package:starter_toolkit/l10n/generated/l10n.dart';

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

    if (statusCode == 500) {
      return Server500Exception(message: responseMessage);
    }

    if (statusCode == 403) {
      return RightsException(responseMessage);
    }

    if (statusCode == 401) {
      return AuthException(responseMessage);
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
    return message ?? ToolkitLocalizer.of(context).errorMessageDefaultRequestError;
  }

  @override
  String getSnackbarDescription(BuildContext context) =>
      getDescription(context);

  @override
  String getTitle(BuildContext context) =>
      ToolkitLocalizer.of(context).errorMessageErrorWhileRequesting;
}
