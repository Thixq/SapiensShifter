// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/splash/view/splash_view.dart';
import 'package:sapiensshifter/feature/splash/view_model/splash_view_model.dart';

mixin SplashViewMixin on BaseState<SplashView> {
  late final SplashViewModel _splashViewModel;

  SplashViewModel get splashViewModel => _splashViewModel;

  @override
  void initState() {
    _splashViewModel = SplashViewModel(
      authManager: FirebaseAuthManagar.instance,
      localCahce: ProductConfigureItems.sharedPreferencesOperation,
    );
    _make();

    super.initState();
  }

  Future<void> _make() async {
    if (await isNetworkAvailable(context)) {
      if (await _splashViewModel.isFirstOpen) {
      } else {
        if (_splashViewModel.isUserOpen) {
        } else {}
      }
    } else {}
  }
}
