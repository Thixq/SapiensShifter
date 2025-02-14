# Firebase Authentication Module

This module provides an authentication system using Firebase, supporting email/password authentication and social logins (Google, Apple). It includes error handling, credential management, and user operations.

## Features
- Firebase email/password authentication
- Google & Apple social login integration
- Exception handling with localization support
- User profile management (update display name, password, and profile picture)

## Usage

### Authentication Manager
Handles authentication processes like signing in and registering users.
```dart
final authManager = FirebaseAuthManagar.instance;

await authManager.registerInWithEmailAndPassword(
  email: 'user@example.com',
  password: 'securepassword',
);
```

### Social Login (Google & Apple)
Uses different credential strategies for authentication.
```dart
final googleCredential = GoogleSignCredential();
final userCredential = await googleCredential.call();
```

### Exception Handling
Provides structured error handling for Firebase authentication errors.
```dart
try {
  await authManager.signInWithEmailAndPassword(
    email: 'user@example.com',
    password: 'wrongpassword',
  );
} catch (e) {
  print(e.toString());
}
```

### User Profile Management
Allows updating user information such as display name, password, and profile photo.
```dart
final userOperation = FirebaseAuthUserOperation.instance;
await userOperation.displayUpdate('New Name');
```

## Dependencies
- `firebase_auth`
- `google_sign_in`
- `sign_in_with_apple`

## License
This project is open-source and free to use.

