// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(hours, minutes) => "${hours} h ${minutes} min";

  static String m1(minutes) => "${minutes} min";

  static String m2(minLength) =>
      "Password must be at least ${minLength} characters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "durationInHoursMinutes": m0,
        "durationInMinutes": m1,
        "errorInvalidEmailFormat":
            MessageLookupByLibrary.simpleMessage("Invalid email format"),
        "errorInvalidLatinAlphanumeric": MessageLookupByLibrary.simpleMessage(
            "Enter only Latin letters and numbers"),
        "errorInvalidPhoneFormat": MessageLookupByLibrary.simpleMessage(
            "For example, +7 (123) 456-78-90"),
        "errorInvalidUrlFormat":
            MessageLookupByLibrary.simpleMessage("Invalid URL format"),
        "errorMessageAuthRequired":
            MessageLookupByLibrary.simpleMessage("Please log in to continue"),
        "errorMessageCheckAndTryLater": MessageLookupByLibrary.simpleMessage(
            "Please check your network connection and try again."),
        "errorMessageCouldNotConnectServer": MessageLookupByLibrary.simpleMessage(
            "Could not connect to server. This may be due to server issues or your internet connection."),
        "errorMessageDefaultRequestError": MessageLookupByLibrary.simpleMessage(
            "Request failed, please try again later"),
        "errorMessageEmptySchedule":
            MessageLookupByLibrary.simpleMessage("Schedule is empty"),
        "errorMessageEmptyScheduleFillInProfile":
            MessageLookupByLibrary.simpleMessage(
                "Go to profile and fill in the schedule"),
        "errorMessageErrorWhileRequesting":
            MessageLookupByLibrary.simpleMessage("Error while making request"),
        "errorMessageMobileBug": MessageLookupByLibrary.simpleMessage(
            "Application error! Please report to developers."),
        "errorMessageNoConnection":
            MessageLookupByLibrary.simpleMessage("No connection to server"),
        "errorMessageNoInternetConnection":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "errorMessageNoRightsToPerform": MessageLookupByLibrary.simpleMessage(
            "You don\'t have permission to perform this action."),
        "errorMessageNoRightsToView": MessageLookupByLibrary.simpleMessage(
            "You don\'t have permission to view this page."),
        "errorMessagePermissionDenied":
            MessageLookupByLibrary.simpleMessage("Access denied"),
        "errorMessagePermissionDeniedSnackbar":
            MessageLookupByLibrary.simpleMessage(
                "Please grant the necessary permissions to continue"),
        "errorMessagePermissionRequired":
            MessageLookupByLibrary.simpleMessage("Permission required"),
        "errorMessageServerError": MessageLookupByLibrary.simpleMessage(
            "Server maintenance in progress"),
        "errorMessageServerInternalError": MessageLookupByLibrary.simpleMessage(
            "Sorry for the inconvenience, the server is temporarily unavailable. Please try again later."),
        "errorMessageUnexpectedError":
            MessageLookupByLibrary.simpleMessage("Something went wrong."),
        "errorMessageUrlLaunchError":
            MessageLookupByLibrary.simpleMessage("Error opening link"),
        "errorPasswordDigit": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one digit"),
        "errorPasswordLowercase": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one lowercase letter"),
        "errorPasswordMinLength": m2,
        "errorPasswordSpecialChar": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one special character"),
        "errorPasswordUppercase": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one uppercase letter"),
        "errorPhoneRequired": MessageLookupByLibrary.simpleMessage(
            "Please enter your phone number"),
        "errorRequiredField":
            MessageLookupByLibrary.simpleMessage("Required field"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday")
      };
}
