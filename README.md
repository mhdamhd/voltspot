# VoltSpot ⚡

*A Flutter application to explore EV charging locations*

---

## 📖 Overview

VoltSpot is a mobile application developed as part of the **Charge Locations assignment**.
Its goal is to fetch and display **electric vehicle (EV) charging locations** by city, show their availability status, and allow users to view details about each charging spot and its connectors (EVSEs).

The project demonstrates **Clean Architecture**, **BLoC state management**, and best practices in Flutter development, with a focus on scalability, testability, and maintainability.

---

Exactly 👍 — the assignment expects you not just to **show** Clean Architecture and BLoC, but to **justify** them.

Here’s a refined section you can drop directly into your README:

---

## 🏛️ Architecture

VoltSpot follows **Clean Architecture** principles, dividing the codebase into three main layers:

* **Data Layer**
  Responsible for fetching data from remote APIs (`Dio`), parsing JSON into models, and converting them into domain entities.

* **Domain Layer**
  Holds business logic, entities, and repository contracts. This layer is completely independent of Flutter and external packages.

* **Presentation Layer**
  Implements **BLoC** for state management and exposes data to the UI. Includes screens, widgets, and components.


### Why Clean Architecture?

Although this assignment could be solved with a simpler structure, we applied **Clean Architecture** to show how the solution can **scale into a larger production app**. Separating layers ensures:

* **Testability**: Each layer can be tested in isolation (e.g., repositories vs. BLoCs).
* **Maintainability**: Business logic does not depend on Flutter, making it easier to evolve.
* **Extensibility**: If tomorrow the app adds authentication, caching, or multiple APIs, the same structure can grow without refactoring the entire codebase.

So while it may feel like overkill for a small task, it demonstrates best practices for building **real-world, enterprise-ready apps**.

### Why BLoC?

We chose **BLoC (Business Logic Component)** for state management because:

* It enforces a **clear separation** between UI and business logic.
* It provides **predictable state transitions** (`loading → success/error → reset`).
* With events and states, the flow is **explicit and testable** — ideal for features like **debounced search** and **reset state**.
* It is widely adopted in the Flutter community, making the code **familiar and maintainable** for other developers.

In short: **BLoC makes the app more robust, testable, and scalable**, even if a simpler `setState` would technically suffice for this assignment.



## 📂 Project Structure

```
lib/
│ main.dart
│
├── core/                   # Shared utilities, components, constants
│   ├── constants/          # Colors, URLs, durations, shadows...
│   ├── core_component/     # Reusable widgets (AppBar, Button, Loading, Empty...)
│   ├── entities/           # Base entities
│   ├── errors/             # Error handling, Failures, Exceptions
│   ├── services/           # ApiServices, Service Locator
│   └── utils/              # BaseState, AppResponse
│
├── modules/
│   └── charge_locations/   # Feature: Charge Locations
│       ├── data/           # Data source, models, repository impl
│       ├── domain/         # Entities, Parameters, Repository contracts
│       └── presentation/   # Blocs, Screens, Components
│
└── home/                   # Home & Splash
```

---

## 📱 Features

* Search charging locations by city with **debounced input** (no unnecessary API calls).
* Display results as a list of **cards** with availability indicators.
* Show **location details**, including EVSE connectors and their statuses.
* **Shimmer loading placeholders** while data is being fetched.
* **Error & empty state handling** (no results, server error, no internet).
* **Unit-tested** BLoCs, models, and repositories.

---

## 🛠️ Dependencies

Key packages used in this project:

* **[flutter\_bloc](https://pub.dev/packages/flutter_bloc)** – predictable state management.
* **[equatable](https://pub.dev/packages/equatable)** – value equality for entities and states.
* **[dio](https://pub.dev/packages/dio)** – networking and API calls.
* **[rxdart](https://pub.dev/packages/rxdart)** – debounce and stream transformations in BLoCs.
* **[shimmer](https://pub.dev/packages/shimmer)** – loading skeletons.
* **[dartz](https://pub.dev/packages/dartz)** – functional error handling (`Either<Failure, T>`).
* **[get\_it](https://pub.dev/packages/get_it)** – service locator for dependency injection.
* **[bloc\_test](https://pub.dev/packages/bloc_test)**, **[mocktail](https://pub.dev/packages/mocktail)** – testing utilities.

---

## 🧪 Testing

The project includes unit tests for:

* **BLoCs** – verifying state transitions (loading, success, error, reset).
* **Models** – verifying JSON serialization and `toEntity()` conversions.
* **Repositories** – verifying data flow and error mapping.

Run all tests:

```bash
flutter test
```

Run a specific test file:

```bash
flutter test test/charge_locations_bloc_test.dart
```

---

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/mhdamhd/voltspot.git
   cd voltspot
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

---

## 💡 Challenges & Solutions

* **Debouncing search queries**  
  Solved using `rxdart`’s `debounceTime` and `switchMap` in the Bloc transformer to prevent unnecessary API calls.

* **Model → Entity mapping**  
  Introduced `BaseModel<T extends BaseEntity>` and helper extensions to ensure consistent conversion across lists and single objects.

* **Handling empty search input**  
  Instead of a separate reset event, the Bloc now checks for empty input directly and emits the initial state, ensuring the UI resets properly without extra events.

* **Testing asynchronous/debounced events**  
  Used `fake_async` with microtask flushing to simulate passage of time and assert state sequences reliably.

---