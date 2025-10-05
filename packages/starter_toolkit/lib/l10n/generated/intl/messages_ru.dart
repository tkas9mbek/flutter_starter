// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(hours, minutes) => "${hours} ч. ${minutes} мин.";

  static String m1(minutes) => "${minutes} мин.";

  static String m2(minLength) =>
      "Пароль должен содержать не менее ${minLength} символов";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "durationInHoursMinutes": m0,
        "durationInMinutes": m1,
        "errorInvalidEmailFormat": MessageLookupByLibrary.simpleMessage(
            "Неверный формат электронной почты"),
        "errorInvalidLatinAlphanumeric": MessageLookupByLibrary.simpleMessage(
            "Введите только латинские буквы и цифры"),
        "errorInvalidPhoneFormat": MessageLookupByLibrary.simpleMessage(
            "Например, +7 (123) 456-78-90"),
        "errorInvalidUrlFormat":
            MessageLookupByLibrary.simpleMessage("Неверный формат URL"),
        "errorMessageAuthRequired": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, войдите в систему, чтобы продолжить"),
        "errorMessageCheckAndTryLater": MessageLookupByLibrary.simpleMessage(
            "Проверьте ваше подключение к сети и попробуйте снова."),
        "errorMessageCouldNotConnectServer": MessageLookupByLibrary.simpleMessage(
            "Не удалось подключиться к серверу. Это может быть из-за проблем с сервером или вашим интернетом."),
        "errorMessageDefaultRequestError": MessageLookupByLibrary.simpleMessage(
            "Запрос не выполнен, попробуйте позже"),
        "errorMessageEmptySchedule":
            MessageLookupByLibrary.simpleMessage("Расписание пусто"),
        "errorMessageEmptyScheduleFillInProfile":
            MessageLookupByLibrary.simpleMessage(
                "Перейдите в профиль и заполните расписание"),
        "errorMessageErrorWhileRequesting":
            MessageLookupByLibrary.simpleMessage(
                "Ошибка при выполнении запроса"),
        "errorMessageMobileBug": MessageLookupByLibrary.simpleMessage(
            "Ошибка приложения! Сообщите разработчикам."),
        "errorMessageNoConnection":
            MessageLookupByLibrary.simpleMessage("Нет соединения с сервером"),
        "errorMessageNoInternetConnection":
            MessageLookupByLibrary.simpleMessage("Нет подключения к интернету"),
        "errorMessageNoRightsToPerform": MessageLookupByLibrary.simpleMessage(
            "У вас нет прав для выполнения этого действия."),
        "errorMessageNoRightsToView": MessageLookupByLibrary.simpleMessage(
            "У вас нет прав для просмотра этой страницы."),
        "errorMessagePermissionDenied":
            MessageLookupByLibrary.simpleMessage("Доступ запрещен"),
        "errorMessagePermissionDeniedSnackbar":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, предоставьте необходимые разрешения для продолжения работы"),
        "errorMessagePermissionRequired":
            MessageLookupByLibrary.simpleMessage("Требуется разрешение"),
        "errorMessageServerError": MessageLookupByLibrary.simpleMessage(
            "Технические работы на сервере"),
        "errorMessageServerInternalError": MessageLookupByLibrary.simpleMessage(
            "Извините за неудобства, сервер временно недоступен. Попробуйте позже."),
        "errorMessageUnexpectedError":
            MessageLookupByLibrary.simpleMessage("Что-то пошло не так."),
        "errorMessageUrlLaunchError":
            MessageLookupByLibrary.simpleMessage("Ошибка при открытии ссылки"),
        "errorPasswordDigit": MessageLookupByLibrary.simpleMessage(
            "Пароль должен содержать хотя бы одну цифру"),
        "errorPasswordLowercase": MessageLookupByLibrary.simpleMessage(
            "Пароль должен содержать хотя бы одну строчную букву"),
        "errorPasswordMinLength": m2,
        "errorPasswordSpecialChar": MessageLookupByLibrary.simpleMessage(
            "Пароль должен содержать хотя бы один специальный символ"),
        "errorPasswordUppercase": MessageLookupByLibrary.simpleMessage(
            "Пароль должен содержать хотя бы одну заглавную букву"),
        "errorPhoneRequired": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите свой номер телефона"),
        "errorRequiredField":
            MessageLookupByLibrary.simpleMessage("Обязательное поле"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Вчера")
      };
}
