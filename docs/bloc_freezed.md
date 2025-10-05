# Bloc + Freezed

Данный документ описывает стандартизированный процесс создания Bloc с применением пакетов
`flutter_bloc` и `freezed`. При реализации заменяйте "Example" на имя конкретной фичи.

* * * * *

1\. Создание файла `example_state.dart`
---------------------------------------

Определите union state с использованием `freezed`. Обычно требуется реализовать следующие состояния:

- **Initial** -- начальное состояние (без данных);
- **Loading** -- состояние загрузки данных;
- **Success** -- успешное получение и отображение данных;
- **Failure** -- ошибка или исключение при выполнении операции.

```
part of 'example_bloc.dart';

@freezed
class ExampleListState with _$ExampleListState {
  const ExampleListState._();

  const factory ExampleListState.initial() = InitialExampleListState;

  const factory ExampleListState.loading() = LoadingExampleListState;

  const factory ExampleListState.success() = SuccessExampleListState;

  const factory ExampleListState.failure(dynamic exception) =
      FailureExampleListState;
}

```

* * * * *

2\. Создание файла `example_event.dart`
---------------------------------------

Определите union-событий с помощью `freezed`. Обычно требуются следующие события:

- **Requested** -- событие запроса данных;
- **Submitted** -- событие подтверждения данных (например, отправка формы);
- **Refreshed** -- событие обновления или перезагрузки данных.

```
part of 'example_bloc.dart';

@freezed
class ExampleEvent with _$ExampleEvent {
  const factory ExampleEvent.requested() = RequestedExampleEvent;
}

```

* * * * *

3\. Создание файла `example_bloc.dart`
--------------------------------------

Реализуйте Bloc следующим образом:

- Импортируйте необходимые пакеты и подключите часть файлов (part).
- Наследуйте класс от `Bloc<ExampleEvent, ExampleState>`.
- Инициализируйте Bloc состоянием `ExampleState.initial()`.
- Обрабатывайте события через метод `on<ExampleEvent>()`.

```
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_bloc.freezed.dart';

part 'example_event.dart';

part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleRepository _repository;

  ExampleBloc(this._repository) : super(const ExampleState.initial()) {
    on<ExampleEvent>(
      (event, emit) => event.when(
        requested: () async {
          try {
            emit(const ExampleState.loading());

            final data = await  _repository.get();

            return emit(ExampleState.success());
          } catch (e) {
            return emit(ExampleState.failure(e));
          }
        },
      ),
    );
  }
}

```

* * * * *

4\. Запуск генератора кода
--------------------------

После создания событий и состояний запустите генератор кода (build_runner) для автоматической генерации вспомогательных методов

```
fvm flutter pub run build_runner build --delete-conflicting-outputs

```

Генератор создает функции:

- **copyWith:** позволяет создавать изменённые копии объектов.
- **when, whenOrNull, maybeWhen**
- **map, mapOrNull, maybeMap:** позволяют обрабатывать логику, зависящую от конкретного состояния.

* * * * *

5\. Обработка операций с BlocListener
-------------------------------------

В случаях, когда функциональность связана с операциями (например, создание или обновление данных), используйте `BlocListener` для:

- Обновления UI-компонентов (например, управление состоянием кнопок) в зависимости от эмитированного состояния.
- Обработки ошибок через состояние **Failure** (например, вызов ExceptionWorker для показа сообщений об ошибке).
- Запуска дополнительных действий (например, навигация или отправка формы) при определённых состояниях.

```
BlocListener<CadastreCertificatesRequestBloc,
    CadastreCertificatesRequestState>(
  listener: (context, state) {
    state.mapOrNull(
      failure: (state) => ExceptionWorker.proccessException(
        state.exception,
        context: context,
      ),
      process: (state) => pay(
        context,
        serviceId: state.serviceId,
        pin: state.pin,
      ),
    );
  },
),

```

* * * * *

6\. Построение UI с BlocBuilder
-------------------------------

Для отображения данных используйте `BlocBuilder`, который строит интерфейс в зависимости от текущего состояния:

- Для состояния **Loading** --- выводите индикатор загрузки (например, `CircularProgressIndicator`).
- Для состояния **Failure** --- отображайте специальный виджет с сообщением об ошибке.
- Для состояния **Success** --- показывайте данные (например, список или другой вид представления).

```
BlocBuilder<CadastreCertificateOptionsListBloc,
    CadastreCertificateOptionsListState>(
  builder: (context, state) => state.maybeMap(
    orElse: () => const Padding(
      padding: EdgeInsets.all(AppSpacing.s16x),
      child: Center(child: CircularProgressIndicator()),
    ),
    failure: (state) => ErrorState(exception: state.exception),
    success: (state) => CadastreCertificateOptionsListView(
      propertyId: propertyId,
      options: state.certificates,
    ),
  ),
);

```

* * * * *

Дополнительно: Расширение классов Freezed
-----------------------------------------

Если необходимо добавить дополнительные методы или свойства в классы состояний:

- Добавьте приватный конструктор (например, `const ExampleState._();`), который позволит расширять
  класс.
- Затем добавьте дополнительные геттеры или методы для удобного доступа к логике внутри состояния.

```
  const ExampleState._();

  bool get loading => maybeMap(loading: (_) => true, orElse: () => false);

```

* * * * *

Дополнительные рекомендации
---------------------------

- Отличная статья ["Flutter Freezed BLoC Without Boilerplate"](https://medium.com/@morning-stars/flutter-freezed-bloc-7-2-0-without-boilerplate-99fe6051f8d) про эту тему
- Скрипт для генерации файлов для VSCode

```
{
	"Freezed Bloc": {
		"prefix": "genbloc",
		"body": [
		  "import 'package:bloc/bloc.dart';",
		  "import 'package:freezed_annotation/freezed_annotation.dart';",
		  "",
		  "part '$TM_FILENAME_BASE.freezed.dart';",
		  "",
		  "@freezed",
		  "class $NAME$Event with _$$NAME$Event {",
		  "",
		  "  const factory $NAME$Event.requested() = _Requested$NAME$Event;",
		  "}",
		  "",
		  "@freezed",
		  "class $NAME$State with _$$NAME$State {",
		  "",
		  "  const factory $NAME$State.initial() = _Initial$NAME$State;",
		  "  const factory $NAME$State.loading() = _Loading$NAME$State;",
		  "  const factory $NAME$State.success() = _Success$NAME$State;",
		  "  const factory $NAME$State.failure() = _Failure$NAME$State;",
		  "}",
		  "",
		  "class $NAME$Bloc extends Bloc<$NAME$Event, $NAME$State> {",
		  "  $NAME$Bloc() : super(const $NAME$State.initial()) {",
		  "",
		  "    on<$NAME$Event>((event, emit) =>",
		  "      event.when(",
		  "        requested: () {},",
		  "      ),",
		  "    );",
		  "  }",
		  "}"
		],
		"description": "Generates basic freezed bloc"
	  }
}
```