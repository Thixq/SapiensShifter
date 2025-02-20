import 'package:core/src/models/base_model_interface.dart';

/// An abstract interface for performing various authentication operations on a user's profile.
/// This interface includes methods for updating the user's password, display name,
/// and profile photograph, as well as a getter to access the current user model.
abstract class IAuthOperation {
  /// Updates the user's password.
  ///
  /// Parameters:
  /// - [newPassword]: The new password to be set for the user.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the password update is successful, otherwise `false`.
  Future<bool> passwordUpdate(String newPassword);

  /// Updates the user's display name.
  ///
  /// Parameters:
  /// - [newName]: The new display name to be set for the user.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the display name update is successful, otherwise `false`.
  Future<bool> displayUpdate(String newName);

  /// Updates the user's profile photograph URL.
  ///
  /// Parameters:
  /// - [newPhotoUrl]: The new URL of the user's profile photograph.
  ///
  /// Returns:
  /// A [Future] that resolves to `true` if the photograph update is successful, otherwise `false`.
  Future<bool> photographUpdate(String newPhotoUrl);

  /// Retrieves the current user model.
  ///
  /// Returns:
  /// A [IBaseModel] representing the current user.
  IBaseModel get user;
}
