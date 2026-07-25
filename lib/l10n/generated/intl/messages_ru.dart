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

  static String m0(seconds) => "Отправить код через ${seconds} сек";

  static String m1(destination) => "Мы отправили код на: ${destination}";

  static String m2(title) => "${title} удалена";

  static String m3(count) =>
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
        "clearAll": MessageLookupByLibrary.simpleMessage("Очистить всё"),
        "completed": MessageLookupByLibrary.simpleMessage("Завершена"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "create": MessageLookupByLibrary.simpleMessage("Создать"),
        "createTask": MessageLookupByLibrary.simpleMessage("Создать задачу"),
        "dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
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
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
        "noTasksForDate":
            MessageLookupByLibrary.simpleMessage("Нет задач на эту дату"),
        "noTasksYet": MessageLookupByLibrary.simpleMessage("Пока нет задач"),
        "notCompleted": MessageLookupByLibrary.simpleMessage("Не завершена"),
        "otpInvalid": MessageLookupByLibrary.simpleMessage(
            "Код неверен или истёк. Попробуйте ещё раз."),
        "otpResend":
            MessageLookupByLibrary.simpleMessage("Отправить код ещё раз"),
        "otpResendIn": m0,
        "otpSubtitle": m1,
        "otpTitle":
            MessageLookupByLibrary.simpleMessage("Введите код подтверждения"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "privacyPolicyComingSoon": MessageLookupByLibrary.simpleMessage(
            "Политика конфиденциальности скоро появится!"),
        "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("Недавние запросы"),
        "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
        "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "searchTasksHint": MessageLookupByLibrary.simpleMessage("Поиск задач"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Выберите дату"),
        "selectLanguage": MessageLookupByLibrary.simpleMessage("Выберите язык"),
        "selectYourBirthday":
            MessageLookupByLibrary.simpleMessage("Выберите дату рождения"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "signInWithCode": MessageLookupByLibrary.simpleMessage("Войти по коду"),
        "signUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "startTime": MessageLookupByLibrary.simpleMessage("Время начала"),
        "startTypingToSearch": MessageLookupByLibrary.simpleMessage(
            "Начните вводить запрос для поиска задач"),
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "system": MessageLookupByLibrary.simpleMessage("Системная"),
        "task": MessageLookupByLibrary.simpleMessage("задача"),
        "taskCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Задача успешно создана"),
        "taskDeleted": m2,
        "taskDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Задача успешно удалена"),
        "taskDescriptionHint":
            MessageLookupByLibrary.simpleMessage("Введите описание задачи"),
        "taskDetails": MessageLookupByLibrary.simpleMessage("Детали задачи"),
        "taskTitle": MessageLookupByLibrary.simpleMessage("Название"),
        "taskTitleHint":
            MessageLookupByLibrary.simpleMessage("Введите название задачи"),
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
        "toContinue": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "toLogin": MessageLookupByLibrary.simpleMessage("Войти"),
        "toLogout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "toRegister":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "version": MessageLookupByLibrary.simpleMessage("Версия"),
        "yearsOld": m3
      };
}
