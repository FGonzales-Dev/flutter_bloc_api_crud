# Flutter BLoC API CRUD

A Flutter application demonstrating CRUD operations using BLoC pattern with API integration.

## What is BLoC?

**BLoC (Business Logic Component)** is an architectural pattern that separates business logic from UI components. It helps create:

- **Testable** applications
- **Reusable** business logic
- **Predictable** state management
- **Clean separation** between presentation and business logic

### BLoC Pattern Benefits:
- **Unidirectional Data Flow**: Data flows in one direction (UI → BLoC → Repository → API)
- **State Management**: Centralized state management with clear state transitions
- **Testability**: Easy to unit test business logic independently
- **Reusability**: Business logic can be reused across different UI components

## Project Structure (`lib/` folder)

```
lib/
├── main.dart                 # App entry point
├── core/                     # Core utilities and configurations
│   └── api/
│       └── api_util.dart     # API configuration and dependency injection
├── data/                     # Data layer (external data sources)
│   ├── datasources/          # Remote data sources (API calls)
│   │   ├── note_remote_datasource.dart
│   │   └── note_remote_datasource_impl.dart
│   ├── models/               # Data models (JSON serialization)
│   │   └── note_model.dart
│   └── repositories/         # Repository implementations
│       └── note_repository_impl.dart
├── domain/                   # Business logic layer
│   ├── entities/             # Business entities (pure Dart objects)
│   │   └── note.dart
│   ├── repositories/         # Repository interfaces (contracts)
│   │   └── note_repository.dart
│   └── usecases/             # Use cases (business operations)
│       └── get_notes.dart
└── presentation/              # UI layer
    ├── bloc/                 # BLoC components
    │   ├── note_bloc.dart    # Business logic controller
    │   ├── note_event.dart    # Events (user actions)
    │   └── note_state.dart    # States (UI states)
    ├── screens/              # Full-screen widgets
    │   └── note_list_screen.dart
    └── widgets/               # Reusable UI components
        ├── note_dialog.dart
        └── note_list_item.dart
```

### Folder Explanations:

#### **`core/`** - Core Utilities
- Contains app-wide configurations and utilities
- **`api_util.dart`**: Centralized API configuration and dependency injection

#### **`data/`** - Data Layer
- Handles external data sources (APIs, databases)
- **`datasources/`**: API implementations for data fetching
- **`models/`**: Data transfer objects with JSON serialization
- **`repositories/`**: Concrete implementations of repository interfaces

#### **`domain/`** - Business Logic Layer
- Contains pure business logic independent of external frameworks
- **`entities/`**: Core business objects (pure Dart classes)
- **`repositories/`**: Abstract interfaces defining data contracts
- **`usecases/`**: Specific business operations and workflows

#### **`presentation/`** - UI Layer
- Contains all UI-related components
- **`bloc/`**: BLoC pattern implementation
  - **`note_bloc.dart`**: Manages business logic and state
  - **`note_event.dart`**: Defines user actions/events
  - **`note_state.dart`**: Defines UI states
- **`screens/`**: Full-screen widgets (pages)
- **`widgets/`**: Reusable UI components

## API Endpoints

- **GET** `/api/v1/notes` - Fetch all notes
- **POST** `/api/v1/note/new` - Create new note
- **PUT** `/api/v1/note/{id}` - Update note
- **DELETE** `/api/v1/note/{id}` - Delete note

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- `flutter_bloc`: State management using BLoC pattern
- `http`: HTTP client for API calls
- `equatable`: Value equality for Dart objects
