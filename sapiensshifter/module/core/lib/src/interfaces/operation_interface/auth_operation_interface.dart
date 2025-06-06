import 'package:core/src/models/auth_model.dart';

abstract class IAuthOperation {
  Future<bool> passwordUpdate(String newPassword);

  Future<bool> displayNameUpdate(String newName);

  Future<bool> photographUpdate(String newPhotoUrl);

  AuthModel? get user;
}
