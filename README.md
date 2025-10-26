# LOGIN APP PROJECT

This is a simple project for login/register to Firebase with email and password.

## PROJECT STRUCTURE

```plaintext
lib
├── core
│   └── storage
│       └── secure_storage
│           ├── secure_storage.dart
│           └── secure_storage_keys.dart
├── di
│   └── di.dart
├── features
│   ├── app
│   │   └── page_names.dart
│   ├── home
│   │   └── presentatuin
│   │       └── ui
│   │           ├── screens
│   │           │   └── home_page_screen.dart
│   │           └── widgets
│   │               ├── home_button.dart
│   │               └── home_text.dart
│   └── login
│       ├── data
│       │   ├── data_source
│       │   │   └── firebase_auth_datasource.dart
│       │   └── repositories
│       │       └── auth_repository_impl.dart
│       ├── domain
│       │   ├── entities
│       │   │   └── user_entity.dart
│       │   ├── repositories
│       │   │   └── auth_repository.dart
│       │   └── usecases
│       │       └── sign_in_usecase.dart
│       └── presentation
│           ├── cubit
│           │   ├── auth_cubit.dart
│           │   └── auth_state.dart
│           └── ui
│               ├── screens
│               │   └── login_page_screen.dart
│               └── widgets
│                   └── login_button.dart
├── main.dart
├── router
│   └── app_router.dart
└── utils
    └── firebase_options.dart

## PROJECT TECHNOLOGIES

- Navigation - go_router
- State Management - flutter_bloc (cubit)
- DI - get_it
- Token Storage - flutter_secure_storage
- API - Firebase
```
