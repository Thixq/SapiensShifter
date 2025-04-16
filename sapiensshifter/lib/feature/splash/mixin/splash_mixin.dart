// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/splash/view/splash_view.dart';
import 'package:sapiensshifter/feature/splash/view_model/enum/splash_state_enum.dart';
import 'package:sapiensshifter/feature/splash/view_model/splash_view_model.dart';

mixin SplashViewMixin on BaseState<SplashView> {
  late final SplashViewModel _splashViewModel;

  SplashViewModel get splashViewModel => _splashViewModel;

  @override
  void initState() {
    _splashViewModel = SplashViewModel(
      authManager: ProductConfigureItems.authManager,
      localCahce: ProductConfigureItems.sharedPreferencesOperation,
    );
    _goRoute;

    super.initState();
  }

  Future<void> get _goRoute async {
    if (mounted) {
      _splashViewModel.route(context, await _check());
    }
  }

  Future<SplashStateEnum> _check() async {
    if (!await isNetworkAvailable(context)) return SplashStateEnum.NO_NETWORK;
    if (!await _splashViewModel.isFirstOpen) {
      return SplashStateEnum.FIRST_LAUNCH;
    }
    return _splashViewModel.isUserOpen
        ? SplashStateEnum.RETURNIG_USER
        : SplashStateEnum.NEW_USER;
  }
}
