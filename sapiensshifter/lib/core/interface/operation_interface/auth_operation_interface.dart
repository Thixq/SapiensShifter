import 'package:sapiensshifter/core/model/sapi_user_model.dart';

abstract class AuthOperationInterface {
  Future<bool> passwordUpdate(String newPassword);
  Future<bool> displayUpdate(String newName);
  Future<bool> photographUpdate(String newPhotoUrl);
  SapiUserModel get user;
}
