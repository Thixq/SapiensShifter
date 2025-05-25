import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';

import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class SettingsViewModel {
  SettingsViewModel({required Profile profile}) : _profile = profile;

  final Profile _profile;

  SapiensUser? get getUser => _profile.user;

  Future<void> signOut(BuildContext context) async {
    final result = await _profile.signOut();
    if (result) {
      if (context.mounted) {
        await context.router.pushAndPopUntil(
          const SignInRoute(),
          predicate: (route) => false,
        );
      }
    }
  }
}
