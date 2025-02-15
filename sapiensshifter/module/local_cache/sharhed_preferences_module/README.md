# Shared Preferences Operation

A simple Dart package for managing local key-value storage using the [SharedPreferences](https://pub.dev/packages/shared_preferences) package. It provides a singleton interface to easily write, read, update, and delete data with built-in type safety and error handling.

## Features

- **Singleton Pattern:** Access the shared preferences functions via a single instance.
- **Type-Safe Writes:** Supports writing basic types such as `String`, `bool`, `int`, `double`, and `List<String>`.
- **Batch Operations:** Write multiple key-value pairs at once.
- **Asynchronous API:** All methods are asynchronous for smooth, non-blocking operations.
- **Custom Exception Handling:** Provides clear error messages for common issues like missing keys or type mismatches.
- **Testability:** Allows injection of custom SharedPreferences instances for easier testing.
