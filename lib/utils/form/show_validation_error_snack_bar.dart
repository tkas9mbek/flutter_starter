import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_starter/uikit/notification/notification_snack_bar.dart';

void showValidationErrorSnackBar(
  BuildContext context,
  GlobalKey<FormBuilderState> formKey,
) {
  formKey.currentState?.saveAndValidate();

  final errorText = formKey.currentState?.fields.values
      .firstWhereOrNull(
        (element) => element.errorText != null,
      )
      ?.errorText;

  if (errorText != null) {
    NotificationSnackBar.showMessage(
      context,
      message: errorText,
      isSuccess: false,
    );
  }
}
