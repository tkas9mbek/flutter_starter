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

  static String m0(title) => "${title} удалена";

  static String m1(count) =>
      "${Intl.plural(count, one: '${count} год', few: '${count} года', other: '${count} лет')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("О приложении"),
        "age": MessageLookupByLibrary.simpleMessage("Возраст"),
        "appearance": MessageLookupByLibrary.simpleMessage("Внешний вид"),
        "birthday": MessageLookupByLibrary.simpleMessage("День рождения"),
        "birthdayIsRequired":
            MessageLookupByLibrary.simpleMessage("Дата рождения обязательна"),
        "calendar": MessageLookupByLibrary.simpleMessage("Календарь"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "completed": MessageLookupByLibrary.simpleMessage("Завершена"),
        "dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deleteTask": MessageLookupByLibrary.simpleMessage("Удалить задачу"),
        "deleteTaskConfirmation": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите удалить эту задачу?"),
        "description": MessageLookupByLibrary.simpleMessage("Описание"),
        "endTime": MessageLookupByLibrary.simpleMessage("Время окончания"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Введите пароль"),
        "enterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Введите номер телефона"),
        "enterYourName":
            MessageLookupByLibrary.simpleMessage("Введите ваше имя"),
        "failedToDeleteTask":
            MessageLookupByLibrary.simpleMessage("Не удалось удалить задачу"),
        "failedToLoadProfile": MessageLookupByLibrary.simpleMessage(
            "Не удалось загрузить профиль"),
        "failedToLoadTaskDetails": MessageLookupByLibrary.simpleMessage(
            "Не удалось загрузить детали задачи"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Уже есть аккаунт?"),
        "haveNoAccount": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "light": MessageLookupByLibrary.simpleMessage("Светлая"),
        "loggingOut":
            MessageLookupByLibrary.simpleMessage("Выход из системы..."),
        "login": MessageLookupByLibrary.simpleMessage("Вход"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "noTasksForDate":
            MessageLookupByLibrary.simpleMessage("Нет задач на эту дату"),
        "noTasksYet": MessageLookupByLibrary.simpleMessage("Пока нет задач"),
        "notCompleted": MessageLookupByLibrary.simpleMessage("Не завершена"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "privacyPolicyComingSoon": MessageLookupByLibrary.simpleMessage(
            "Политика конфиденциальности скоро появится!"),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
        "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Выберите дату"),
        "selectLanguage": MessageLookupByLibrary.simpleMessage("Выберите язык"),
        "selectYourBirthday":
            MessageLookupByLibrary.simpleMessage("Выберите дату рождения"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "signUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "startTime": MessageLookupByLibrary.simpleMessage("Время начала"),
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "task": MessageLookupByLibrary.simpleMessage("задача"),
        "taskDeleted": m0,
        "taskDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Задача успешно удалена"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("Детали задачи"),
        "tasks": MessageLookupByLibrary.simpleMessage("Задачи"),
        "tasks_many": MessageLookupByLibrary.simpleMessage("задач"),
        "tasks_plural": MessageLookupByLibrary.simpleMessage("задачи"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Условия использования"),
        "termsComingSoon": MessageLookupByLibrary.simpleMessage(
            "Условия использования скоро появятся!"),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "themeSwitchingComingSoon": MessageLookupByLibrary.simpleMessage(
            "Переключение темы скоро появится!"),
        "toLogin": MessageLookupByLibrary.simpleMessage("Войти"),
        "toLogout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "toRegister":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "version": MessageLookupByLibrary.simpleMessage("Версия"),
        "yearsOld": m1
      };
}
