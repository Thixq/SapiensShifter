import 'package:core/core.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/product/models/sapiens_user.dart';

class Profile {
  Profile();
  final INetworkManager networkManager = FirebaseFirestoreManager.instance;
  final IAuthManager authManager = FirebaseAuthManagar.instance;
  late final SapiensUser sapiensUser;

  Future<void> getCurrentProfile() async {
    final currentProfileId = authManager.authOperation.user?.id;
    sapiensUser = await networkManager.networkOperation
        .getItem(path: '/users/$currentProfileId', model: const SapiensUser());
  }

  void name(params) {}
}
