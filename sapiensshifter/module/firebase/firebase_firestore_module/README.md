# Firebase Firestore Operation

## Overview
`FirebaseFirestoreOperation` is a type-safe class designed to handle Firestore operations efficiently. It works with models implementing `BaseModelInterface<T>` and provides a structured way to perform CRUD (Create, Read, Update, Delete) operations using Firestore's SDK.

## Features
- **CRUD Operations:**
  - Add (`addItem`, `addAllItem`)
  - Update (`update`, `replaceItem`)
  - Delete (`deleteItem`)
  - Retrieve (`getItem`, `getItemsQuery`)
- **Error Handling:**
  - Uses `handleAsyncOperation<bool, FirebaseException>` for structured exception handling.
  - Custom exception `ModuleFirestoreException` is thrown when an error occurs.
- **Batch Processing:**
  - Supports batch operations with `_processBatchedOperations`, ensuring efficient handling of Firestore limits.
  - `_deleteCollection` removes all documents within a collection using Firestore’s `WriteBatch`.
- **Helper Mixin:**
  - `FirestoreHelperMixin` provides additional helper functions such as `_getCollectionAndDocId` to manage Firestore paths efficiently.

## How It Works
### 1. **Adding an Item**
```dart
await firestoreOperation.addItem(
  path: 'users/user123',
  item: UserModel(name: 'John Doe', age: 30),
);
```
- If `user123` exists, the document is updated.
- If `user123` does not exist, a new document is created.

### 2. **Adding Multiple Items in Batch**
```dart
await firestoreOperation.addAllItem(
  path: 'users',
  items: [UserModel(name: 'Alice'), UserModel(name: 'Bob')],
);
```
- Adds multiple users in a single batch (max 500 per batch).

### 3. **Retrieving an Item**
```dart
UserModel user = await firestoreOperation.getItem(path: 'users/user123');
print(user.name);
```

### 4. **Querying Multiple Items**
```dart
List<UserModel> users = await firestoreOperation.getItemsQuery(path: 'users');
```

### 5. **Updating an Item**
```dart
await firestoreOperation.update(
  path: 'users/user123',
  value: {'age': 31},
);
```

### 6. **Deleting an Item**
```dart
await firestoreOperation.deleteItem(path: 'users/user123');
```

## Conclusion
`FirebaseFirestoreOperation` simplifies Firestore operations, ensuring efficiency, error handling, and batch processing for large-scale applications.

