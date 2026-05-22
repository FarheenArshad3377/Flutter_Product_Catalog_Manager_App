# assignment_9
# Flutter Product Catalog Manager App

A mobile app built with Flutter that allows users to manage a product catalog using a live REST API (crudcrud.com) and Provider for state management.

## Features

- View all products in a clean list
- Add new products
- Edit existing products
- Delete products with confirmation
- Loading, empty, and error states handled gracefully

## Tech Stack

- **Flutter** — UI framework
- **Provider** — State management
- **HTTP** — REST API calls
- **crudcrud.com** — Live backend API

## Folder Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/api_constants.dart
│   └── theme/app_theme.dart
├── models/product.dart
├── services/product_service.dart
├── providers/product_provider.dart
└── views/
    ├── home/
    │   ├── home_screen.dart
    │   └── widgets/
    └── product_form/
        └── product_form_screen.dart
```

## Getting Started

1. Clone the repo
2. Run `flutter pub get`
3. Get your free API endpoint from [crudcrud.com](https://crudcrud.com)
4. Paste your unique ID in `lib/core/constants/api_constants.dart`
5. Run `flutter run`

## API

This app uses [crudcrud.com](https://crudcrud.com) as a free REST backend supporting GET, POST, PUT, and DELETE operations.

> **Note:** crudcrud resets every 24 hours. Update your endpoint URL when it expires.
