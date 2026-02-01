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

  static String m0(title) => "${title} deleted";

  static String m1(count) =>
      "${Intl.plural(count, one: '${count} year old', other: '${count} years old')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "age": MessageLookupByLibrary.simpleMessage("Age"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "birthday": MessageLookupByLibrary.simpleMessage("Birthday"),
        "birthdayIsRequired":
            MessageLookupByLibrary.simpleMessage("Birthday is required"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteTask": MessageLookupByLibrary.simpleMessage("Delete Task"),
        "deleteTaskConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this task?"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "endTime": MessageLookupByLibrary.simpleMessage("End Time"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Enter password"),
        "enterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Enter phone number"),
        "enterYourName":
            MessageLookupByLibrary.simpleMessage("Enter your name"),
        "failedToDeleteTask":
            MessageLookupByLibrary.simpleMessage("Failed to delete task"),
        "failedToLoadProfile":
            MessageLookupByLibrary.simpleMessage("Failed to load profile"),
        "failedToLoadTaskDetails":
            MessageLookupByLibrary.simpleMessage("Failed to load task details"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "haveNoAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "loggingOut": MessageLookupByLibrary.simpleMessage("Logging out..."),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noTasksForDate":
            MessageLookupByLibrary.simpleMessage("No tasks for this date"),
        "noTasksYet": MessageLookupByLibrary.simpleMessage("No tasks yet"),
        "notCompleted": MessageLookupByLibrary.simpleMessage("Not Completed"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "privacyPolicyComingSoon":
            MessageLookupByLibrary.simpleMessage("Privacy Policy coming soon!"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Select a date"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select language"),
        "selectYourBirthday":
            MessageLookupByLibrary.simpleMessage("Select your birthday"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "startTime": MessageLookupByLibrary.simpleMessage("Start Time"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "task": MessageLookupByLibrary.simpleMessage("task"),
        "taskDeleted": m0,
        "taskDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Task deleted successfully"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tasks_many": MessageLookupByLibrary.simpleMessage("tasks"),
        "tasks_plural": MessageLookupByLibrary.simpleMessage("tasks"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "termsComingSoon": MessageLookupByLibrary.simpleMessage(
            "Terms and Conditions coming soon!"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "themeSwitchingComingSoon": MessageLookupByLibrary.simpleMessage(
            "Theme switching coming soon!"),
        "toLogin": MessageLookupByLibrary.simpleMessage("Log In"),
        "toLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
        "toRegister": MessageLookupByLibrary.simpleMessage("Register"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "yearsOld": m1
      };
}
