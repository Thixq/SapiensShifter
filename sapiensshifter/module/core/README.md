# Core Module Documentation

This module serves as the foundation for managing essential operations such as authentication, local caching, and network store interactions. The purpose of this module is to provide reusable interfaces and models to ensure consistency and flexibility throughout the application.

---

## Table of Contents
1. [Overview](#overview)
2. [Interfaces](#interfaces)
   - [AuthManagerInterface](#authmanagerinterface)
   - [AuthOperationInterface](#authoperationinterface)
   - [CredentialStrategyInterface](#credentialstrategyinterface)
   - [LocalCacheManagerInterface](#localcachemanagerinterface)
   - [LocalCacheOperationInterface](#localcacheoperationinterface)
   - [NetworkStoreQueryInterface](#networkstorequeryinterface)
   - [NetworkStoreOperationInterface](#networkstoreoperationinterface)
   - [BaseModelInterface](#basemodelinterface)
3. [Models](#models)
   - [CustomCredential](#customcredential)
4. [How to Use](#how-to-use)

---

## Overview
This module defines a set of abstract classes and models to:
- Standardize authentication flows.
- Handle local cache operations.
- Query and manipulate data from a network store.
- Provide reusable and extendable base models for JSON serialization/deserialization.

---

## Interfaces

### AuthManagerInterface
Provides methods for handling authentication operations such as signing in, signing out, and registering users.

```dart
abstract class AuthManagerInterface {
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> signInWithCredential({required CustomCredential credential});
  Future<bool> signOut();
}
```

---

### AuthOperationInterface
Defines operations to update user information, such as password, display name, and profile photo.

```dart
abstract class AuthOperationInterface {
  Future<bool> passwordUpdate(String newPassword);
  Future<bool> displayUpdate(String newName);
  Future<bool> photographUpdate(String newPhotoUrl);
  UserModel get user;
}
```

---

### CredentialStrategyInterface
Defines a single method for retrieving or generating a custom credential using a specific strategy.

```dart
abstract class CredentialStrategyInterface {
  Future<CustomCredential> call();
}
```

---

### LocalCacheManagerInterface
Provides an interface for managing local cache initialization and cleanup.

```dart
abstract class LocalCacheManagerInterface {
  const LocalCacheManagerInterface({this.path});
  Future<void> init();
  Future<bool> remove();
  final String? path;
}
```

---

### LocalCacheOperationInterface
Defines operations for reading, writing, updating, and deleting key-value pairs in the local cache.

```dart
abstract class LocalCacheOperationInterface {
  Future<bool> write<T>({required String key, required T value});
  Future<bool> writeAll({required Map<String, dynamic> items});
  Future<MapEntry<String, T>> getValue<T>({required String key});
  Future<Map<String, dynamic>> getAllValue();
  Future<bool> delete({required String key});
  Future<bool> updateValue({required String key, required dynamic newValue});
}
```

---

### NetworkStoreQueryInterface
Defines a structure for querying data from a network store using filters, ordering, and limits.

```dart
abstract class NetworkStoreQueryInterface {
  NetworkStoreQueryInterface({
    this.limit,
    this.limitToLast,
    this.orderBy,
    this.filters,
  });
  final int? limit;
  final int? limitToLast;
  final List<OrderByCondition>? orderBy;
  final List<FilterCondition>? filters;
  T applyToCollection<T>(String path);
}
```

---

### NetworkStoreOperationInterface
Provides methods for performing CRUD operations on a network store.

```dart
abstract class NetworkStoreOperationInterface<T extends BaseModelInterface<T>> {
  Future<T> getItem({required String path, String? key});
  Future<List<T>> getItemsQuery({
    required String path,
    String? key,
    NetworkStoreQueryInterface? query,
  });
  Future<bool> addItem({
    required String path,
    required T item,
  });
  Future<bool> addAllItem({required String path, required List<T> items});
  Future<bool> update({
    required String path,
    required Map<String, dynamic> value,
  });
  Future<bool> replaceItem({
    required String path,
    required T item,
    String? key,
  });
  Future<bool> deleteItem({required String path, String? key});
}
```

---

### BaseModelInterface
Standardizes JSON serialization/deserialization for models.

```dart
abstract class BaseModelInterface<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

---

## Models

### CustomCredential
Represents a set of credentials required for authentication.

```dart
final class CustomCredential {
  const CustomCredential({
    required this.providerId,
    this.accessToken,
    this.idToken,
  });
  final String providerId;
  final String? accessToken;
  final String? idToken;
}
```

---

## How to Use

1. **Extend Interfaces**: Implement the interfaces in your application to define specific behaviors.
   ```dart
   class FirebaseAuthManager implements AuthManagerInterface {
     @override
     Future<bool> signInWithEmailAndPassword({
       required String email,
       required String password,
     }) {
       // Your implementation here.
     }
     // Other methods...
   }
   ```

2. **Create Models**: Use the `BaseModelInterface` to create models that can be serialized and deserialized.
   ```dart
   class UserModel extends BaseModelInterface<UserModel> {
     @override
     UserModel fromJson(Map<String, dynamic> json) {
       // Your implementation here.
     }

     @override
     Map<String, dynamic> toJson() {
       // Your implementation here.
     }
   }
   ```

3. **Use Query Interfaces**: Leverage `NetworkStoreQueryInterface` for querying network stores with filtering, ordering, and limiting capabilities.

---

This documentation provides an overview of the module's purpose and structure, ensuring it is easy to understand and integrate into your projects.

