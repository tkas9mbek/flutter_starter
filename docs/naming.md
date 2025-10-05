### Naming Conventions

Мы должны стремиться к тому, чтобы, прочитав название класса, функции или переменной, разработчики
могли легко понять его назначение, тип и принадлежность к определённому функционалу. Это можно
достичь, следуя приведённым ниже соглашениям об именовании и принципу единственной ответственности.

### General

- Functions & Methods: Should be named starting with a verb, indicating the action they perform,
  e.g. `doSomething()`, `fetchData()`

- Classes follow the pattern: **Feature + Description + Type**:

- Description: Describes the specific use case or data being represented (e.g., `Certificate`,
  `NotesList`, `ItemCreation`).

    - Single Implementations: For classes where only one implementation of a certain type is
      expected within a feature, the **Description** part can be omitted, e.g. `FeatureRepository`
      instead of `FeatureMainRepository`
- Type: Indicates the type of class (e.g., `RequestBody`, `Details`, `Column`, `Bloc`, `Screen`).
  Avoid generic names like Model or Data.

    - For data models if the type is self-evident from the context, it can be omitted, e.g.
      `FeatureItemPrice` instead of `FeatureItemPriceDetails`.

### Abstraction

- Abstract Classes: Follow the main naming rule (e.g., FeatureDataProvider).
- Concrete Implementations: Follow the pattern: SpecificImplementation + AbstractClassName, e.g.
  `RemoteFeatureDataProvider`, `LocalFeatureDataProvider`.

### Widget

- **Generic Widgets** If a widget doesn't have a more descriptive name based on its function, use
  its basic widget type, e.g. `FeatureDescriptionRow`, `UserProfileColumn`.
- **Avoid `Container`, `Widget`** Generally, avoid using Container in widget names as it's too
  generic. Prefer Card for containers with visual decoration (e.g., FeatureDetailsCard).
- **Example** `FeatureItemsListView`, `FeatureDetailsScreen`, `FeatureItemDeletionButton`,
  `FeatureTitleValueTile`.

### Bloc

- Adhere to the official Bloc Library naming
  conventions: <https://bloclibrary.dev/naming-conventions/>
- For naming BLoCs and their primary states and events, follow the **Feature + Description + Type**
  pattern, e.g. `FeatureItemListBloc`, `FeatureOperationState`, `UserAuthenticationEvent`.
- **Events** Event names should typically be in the past tense, as they represent actions that have
  already occurred from the BLoC's perspective, e.g. `itemRequested`, `formSubmitted`.
- **States** State names should be nouns, representing a snapshot of the BLoC's state at a
  particular point in time, e.g. `success`, `failure`, `loading`.
- Common Bloc Names:
    - For fetching lists of data: FeatureListBloc (e.g., NotesListBloc).
    - For creating or editing single items: FeatureOperationBloc (e.g., NoteOperationBloc).
    - For managing the details of a specific item: FeatureDetailsBloc (e.g., UserDetailsBloc).

### Comments

- Minimize Code Comments: Aim to write self-documenting code that is clear enough not to require
  extensive comments. Excessive commenting can make classes large and less readable.
- Focus on Public API Documentation: For common module, uikit follow Flutter's convention for
  documentation comments using `///`. Provide a concise summary and explain the purpose and usage of
  the API. For example:

```
    /// A box with a specified size.
    ///
    /// If not given a child, [SizedBox] will try to size itself as close to the
    /// specified height and width as possible given the parent's constraints. If
    /// [height] or [width] is null or unspecified, it will be treated as zero.

```

Примеры названий классов и объяснения их соответствия правилам
==============================================================

* * * * *

### 1\. TaxRepository

- **Feature:** Tax
- **Description:** (опционально, так как репозиторий предполагается один для фичи Tax)
- **Type:** Repository
- **Объяснение:**
  Название **TaxRepository** чётко указывает, что данный класс предназначен для работы с данными,
  связанными с функционалом налогов, и выполняет роль репозитория. Поскольку в рамках фичи Tax
  ожидается единственная реализация данного типа, опускание дополнительного описания допустимо.

* * * * *

### 2\. TaxPaymentScreen

- **Feature:** Tax
- **Description:** Payment
- **Type:** Screen
- **Объяснение:**
  Название **TaxPaymentScreen** информирует, что данный экран (Screen) предназначен для работы с
  операциями, связанными с оплатой налогов. Функциональные аспекты (налоговый платеж) и тип (
  UI-экран) выражены явно.

* * * * *

### 3\. TaxDebtsListBloc

- **Feature:** Tax
- **Description:** DebtsList
- **Type:** Bloc
- **Объяснение:**
  В имени **TaxDebtsListBloc** указано, что класс управляет логикой, связанной с отображением или
  обработкой списка долгов (DebtsList) по налоговой тематике. Тип класса -- Bloc -- подчеркивает,
  что он отвечает за бизнес-логику.

* * * * *

### 4\. CreditApprovalBloc

- **Feature:** Credit
- **Description:** Approval
- **Type:** Bloc
- **Объяснение:**
  Название **CreditApprovalBloc** указывает на то, что класс работает с процессом утверждения
  кредитов (Approval) в рамках функционала кредитов. Данный Bloc предназначен для реализации
  бизнес-логики, связанной с одобрением.

* * * * *

### 5\. CreditApplicationScreen

- **Feature:** Credit
- **Description:** Application
- **Type:** Screen
- **Объяснение:**
  В **CreditApplicationScreen** ясно выражено, что данный экран предназначен для подачи кредитных
  заявок (Application) в функционале Credit. Название интуитивно понятное и соответствует
  предполагаемой роли UI-элемента.

* * * * *

### 6\. CreditScoreCard

- **Feature:** Credit
- **Description:** Score
- **Type:** Card
- **Объяснение:**
  Название **CreditScoreCard** говорит о том, что класс представляет карточку (Card) с информацией о
  кредитном скоре (Score) для функционала Credit. Использование слова "Card" вместо общего "Widget"
  делает тип элемента более конкретным и понятным.

* * * * *

### 7\. NotificationsUnreadListView

- **Feature:** Notifications
- **Description:** UnreadList
- **Type:** ListView
- **Объяснение:**
  Имя **NotificationsUnreadListView** информирует, что это виджет (ListView), отвечающий за
  отображение списка непрочитанных уведомлений (UnreadList) в рамках функционала уведомлений (
  Notifications). Название точно определяет как функционал, так и тип виджета.

* * * * *

### 8\. RemoteNotificationDataSource

- **Feature:** Notification
- **Description:** Remote
- **Type:** DataSource
- **Объяснение:**
  **RemoteNotificationDataSource** четко указывает, что данный класс (DataSource) является
  конкретной реализацией для получения уведомлений с удалённого сервера (Remote). Это соответствует
  правилу SpecificImplementation + AbstractClassName.

* * * * *

### 9\. NotificationsListBloc

- **Feature:** Notifications
- **Description:** List
- **Type:** Bloc
- **Объяснение:**
  Название **NotificationsListBloc** говорит, что этот Bloc управляет списком уведомлений (List) для
  функционала Notifications. Оно ясно разделяет ответственность и соответствует структуре Feature +
  Description + Type.

* * * * *

### 10\. NotificationsListRequestedEvent

- **Feature:** Notifications
- **Description:** ListRequested
- **Type:** Event
- **Объяснение:**
  ListRequested -- указывает на запрос списка уведомлений; использование прошедшего времени ("
  Requested") соответствует правилам для именования событий. Такое название сразу сообщает, что
  класс представляет собой событие, произошедшее в системе.

* * * * *

Примеры плохих имен классов с объяснениями и их исправления
===========================================================

* * * * *

### 1\. Property

- **Почему плохо:**
  Название "Property" слишком общее и не отражает ни конкретную функциональность, ни тип данных.
  Разработчик не сможет понять, что именно представляет этот класс.
- **Исправлено:** `RealEstateProperty`
- **Объяснение:**
  Новое название включает конкретику -- оно явно указывает, что класс описывает информацию о
  недвижимости (RealEstate), что делает его назначение понятным.

* * * * *

### 2\. TaxPropertyDebtModel

- **Почему плохо:**
  Использование слова `Model` является избыточным, так как этот термин не добавляет конкретики.
- **Исправлено:** `TaxPropertyDebt`
- **Объяснение:**
  Название состоит из фичи (Tax), описания (PropertyDebt) и опускает слово "Model", которое было
  слишком общим. Это позволяет сразу понять, что класс работает с долгами по свойствам в налоговом
  контексте.

* * * * *

### 3\. TitleValueTile

- **Почему плохо:**
  "TitleValueTile" слишком абстрактное имя -- оно не указывает, к какому функционалу относится
  данный компонент и для чего он предназначен.
- **Исправлено:** `TaxPropertyTitleValueTile`
- **Объяснение:**
  Добавление фичи (TaxProperty) конкретизирует область применения, а "TitleValueTile" остается в
  качестве описания типа виджета. Теперь название соответствует схеме: Feature (TaxProperty) +
  Description (TitleValue) + Type (Tile).

* * * * *

### 4\. ImageContainer

- **Почему плохо:**
  Использование слова "Container" слишком общее и не показывает назначение компонента. Неясно,
  используется ли он для форматирования, отображения или другой цели.
- **Исправлено:** `PropertyImageDisplayCard`
- **Объяснение:**
  "Property" - конкретизирует область применения, "ImageDisplay" уточняет, что компонент отвечает за
  показ изображения, а "Card" -- конкретный тип UI-компонента с визуальным оформлением. Название
  стало более информативным и специфичным.

* * * * *

### 5\. AddCompanyBloc

- **Почему плохо:**
  Глагол "Add" нарушает правило использования описательных существительных (например, Creation или
  Addition), а само имя не отражает конкретную зону ответственности Bloc.
- **Исправлено:** `CompanyCreationBloc`
- **Объяснение:**
  Новое название следует схеме: Feature (Company) + Description (Creation) + Type (Bloc). Это ясно
  даёт понять, что данный Bloc отвечает за логику создания компании.

* * * * *

### 6\. CompanyFetchEvent

- **Почему плохо:**
  Название события должно быть более конкретным и, как правило, использовать прошедшее время или
  уточняющий термин для обозначения запроса (например, Requested). "Fetch" само по себе остаётся
  недостаточно описательным.
- **Исправлено:** `CompanyRequestedEvent`
- **Объяснение:**
  Теперь название содержит Feature (Company), описание (Requested, что указывает на то, что
  произошло запрос на получение данных) и тип (Event). Это соответствует требованиям именования
  событий.

* * * * *

### 7\. CompanyLocalDataSource

- **Почему плохо:**
  Порядок компонентов не соответствует паттерну для конкретных реализаций -- согласно критерию
  SpecificImplementation + AbstractClassName, конкретная реализация должна идти первой.
- **Исправлено:** `LocalCompanyDataSource`
- **Объяснение:**
  Новое имя начинается с описания конкретной реализации (`Local`), затем следует фича (Company) и
  тип (DataSource). Такая перестановка улучшает читаемость и соответствует установленным правилам.

* * * * *

### 8\. AddCompanyWidget

- **Почему плохо:**
  Использование слова "Widget" слишком расплывчато, так как оно не указывает на конкретный тип
  UI-компонента (например, Button или Form), а глагол "Add" не соответствует схеме именования.
- **Исправлено:** `CompanyCreationButton`
- **Объяснение:**
  В исправленном имени используется существительное "Creation" вместо глагола "Add", что, вместе с
  указанием конкретного типа UI-компонента (Button), делает название более конкретным и понятным по
  схеме Feature (Company) + Description (Creation) + Type (Button).

* * * * *

### 9\. MainScreen

- **Почему плохо:**
  "MainScreen" --- слишком общее название, не указывающее на принадлежность к конкретной
  функциональной области или описывающее его назначение.
- **Исправлено:** `HomeDashboardScreen`
- **Объяснение:**
  Новое название включает фичу (Home), описание (Dashboard) и тип (Screen), что делает
  предназначение экрана очевидным и однозначно определённым.