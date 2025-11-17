### Naming Conventions

We should strive to ensure that by reading the name of a class, function, or variable, developers
can easily understand its purpose, type, and belonging to a specific functionality. This can be
achieved by following the naming conventions and single responsibility principle outlined below.

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

Examples of Class Names and Explanations of Their Compliance with the Rules
==============================================================

* * * * *

### 1\. TaxRepository

- **Feature:** Tax
- **Description:** (optional, as only one repository is expected for the Tax feature)
- **Type:** Repository
- **Explanation:**
  The name **TaxRepository** clearly indicates that this class is designed to work with data
  related to tax functionality and serves the role of a repository. Since only a single
  implementation of this type is expected within the Tax feature, omitting additional description
  is acceptable.

* * * * *

### 2\. TaxPaymentScreen

- **Feature:** Tax
- **Description:** Payment
- **Type:** Screen
- **Explanation:**
  The name **TaxPaymentScreen** indicates that this screen is designed to work with operations
  related to tax payments. The functional aspects (tax payment) and type (UI screen) are clearly
  expressed.

* * * * *

### 3\. TaxDebtsListBloc

- **Feature:** Tax
- **Description:** DebtsList
- **Type:** Bloc
- **Explanation:**
  The name **TaxDebtsListBloc** indicates that the class manages logic related to displaying or
  processing a list of debts (DebtsList) in the tax domain. The class type -- Bloc -- emphasizes
  that it is responsible for business logic.

* * * * *

### 4\. CreditApprovalBloc

- **Feature:** Credit
- **Description:** Approval
- **Type:** Bloc
- **Explanation:**
  The name **CreditApprovalBloc** indicates that the class works with the credit approval process
  (Approval) within credit functionality. This Bloc is designed to implement business logic
  related to approval.

* * * * *

### 5\. CreditApplicationScreen

- **Feature:** Credit
- **Description:** Application
- **Type:** Screen
- **Explanation:**
  In **CreditApplicationScreen**, it is clearly expressed that this screen is designed for
  submitting credit applications (Application) within the Credit functionality. The name is
  intuitive and corresponds to the intended role of the UI element.

* * * * *

### 6\. CreditScoreCard

- **Feature:** Credit
- **Description:** Score
- **Type:** Card
- **Explanation:**
  The name **CreditScoreCard** indicates that the class represents a card (Card) with information
  about credit score (Score) for the Credit functionality. Using the word "Card" instead of the
  generic "Widget" makes the element type more specific and understandable.

* * * * *

### 7\. NotificationsUnreadListView

- **Feature:** Notifications
- **Description:** UnreadList
- **Type:** ListView
- **Explanation:**
  The name **NotificationsUnreadListView** indicates that this is a widget (ListView) responsible
  for displaying a list of unread notifications (UnreadList) within the notifications
  functionality (Notifications). The name accurately defines both the functionality and the widget
  type.

* * * * *

### 8\. RemoteNotificationDataSource

- **Feature:** Notification
- **Description:** Remote
- **Type:** DataSource
- **Explanation:**
  **RemoteNotificationDataSource** clearly indicates that this class (DataSource) is a specific
  implementation for retrieving notifications from a remote server (Remote). This corresponds to
  the SpecificImplementation + AbstractClassName rule.

* * * * *

### 9\. NotificationsListBloc

- **Feature:** Notifications
- **Description:** List
- **Type:** Bloc
- **Explanation:**
  The name **NotificationsListBloc** indicates that this Bloc manages the list of notifications
  (List) for the Notifications functionality. It clearly separates responsibilities and
  corresponds to the Feature + Description + Type structure.

* * * * *

### 10\. NotificationsListRequestedEvent

- **Feature:** Notifications
- **Description:** ListRequested
- **Type:** Event
- **Explanation:**
  ListRequested -- indicates a request for the list of notifications; using the past tense
  ("Requested") complies with event naming rules. This name immediately communicates that the
  class represents an event that occurred in the system.

* * * * *

Examples of Bad Class Names with Explanations and Their Corrections
===========================================================

* * * * *

### 1\. Property

- **Why It's Bad:**
  The name "Property" is too generic and does not reflect either specific functionality or data
  type. A developer cannot understand what this class represents.
- **Fixed:** `RealEstateProperty`
- **Explanation:**
  The new name includes specificity -- it explicitly indicates that the class describes
  information about real estate (RealEstate), which makes its purpose clear.

* * * * *

### 2\. TaxPropertyDebtModel

- **Why It's Bad:**
  Using the word `Model` is redundant, as this term does not add specificity.
- **Fixed:** `TaxPropertyDebt`
- **Explanation:**
  The name consists of the feature (Tax), description (PropertyDebt), and omits the word "Model",
  which was too generic. This allows immediate understanding that the class works with property
  debts in a tax context.

* * * * *

### 3\. TitleValueTile

- **Why It's Bad:**
  "TitleValueTile" is too abstract a name -- it does not indicate what functionality this
  component belongs to or what it is intended for.
- **Fixed:** `TaxPropertyTitleValueTile`
- **Explanation:**
  Adding the feature (TaxProperty) specifies the scope of application, while "TitleValueTile"
  remains as the description of the widget type. Now the name follows the pattern: Feature
  (TaxProperty) + Description (TitleValue) + Type (Tile).

* * * * *

### 4\. ImageContainer

- **Why It's Bad:**
  Using the word "Container" is too generic and does not show the component's purpose. It's
  unclear whether it's used for formatting, display, or another purpose.
- **Fixed:** `PropertyImageDisplayCard`
- **Explanation:**
  "Property" - specifies the scope of application, "ImageDisplay" clarifies that the component is
  responsible for displaying images, and "Card" -- a specific type of UI component with visual
  decoration. The name became more informative and specific.

* * * * *

### 5\. AddCompanyBloc

- **Why It's Bad:**
  The verb "Add" violates the rule of using descriptive nouns (e.g., Creation or Addition), and
  the name itself does not reflect the specific area of responsibility of the Bloc.
- **Fixed:** `CompanyCreationBloc`
- **Explanation:**
  The new name follows the pattern: Feature (Company) + Description (Creation) + Type (Bloc). This
  clearly communicates that this Bloc is responsible for company creation logic.

* * * * *

### 6\. CompanyFetchEvent

- **Why It's Bad:**
  The event name should be more specific and typically use past tense or a clarifying term to
  denote a request (e.g., Requested). "Fetch" itself remains insufficiently descriptive.
- **Fixed:** `CompanyRequestedEvent`
- **Explanation:**
  Now the name contains Feature (Company), description (Requested, indicating that a request to
  retrieve data occurred) and type (Event). This complies with event naming requirements.

* * * * *

### 7\. CompanyLocalDataSource

- **Why It's Bad:**
  The order of components does not match the pattern for concrete implementations -- according to
  the SpecificImplementation + AbstractClassName criterion, the specific implementation should
  come first.
- **Fixed:** `LocalCompanyDataSource`
- **Explanation:**
  The new name starts with the description of the specific implementation (`Local`), followed by
  the feature (Company) and type (DataSource). This rearrangement improves readability and
  complies with established rules.

* * * * *

### 8\. AddCompanyWidget

- **Why It's Bad:**
  Using the word "Widget" is too vague, as it does not indicate the specific type of UI component
  (e.g., Button or Form), and the verb "Add" does not correspond to the naming pattern.
- **Fixed:** `CompanyCreationButton`
- **Explanation:**
  The corrected name uses the noun "Creation" instead of the verb "Add", which, together with
  specifying the specific UI component type (Button), makes the name more specific and
  understandable according to the Feature (Company) + Description (Creation) + Type (Button)
  pattern.

* * * * *

### 9\. MainScreen

- **Why It's Bad:**
  "MainScreen" --- is too generic a name, not indicating belonging to a specific functional area
  or describing its purpose.
- **Fixed:** `HomeDashboardScreen`
- **Explanation:**
  The new name includes the feature (Home), description (Dashboard), and type (Screen), which
  makes the screen's purpose obvious and clearly defined.