import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/constant/page_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/feature/splash/view_model/enum/splash_state_enum.dart';

final class SplashViewModel {
  SplashViewModel({
    required ILocalCacheManager localCahce,
    required IAuthManager authManager,
  })  : _authManagar = authManager,
        _localCahce = localCahce;
  final ILocalCacheManager _localCahce;
  final IAuthManager _authManagar;

  Future<bool> get isFirstOpen async {
    return ErrorUtil.runWithErrorHandling(
      action: () async {
        final result = await _localCahce.cacheOperation
            .getValue<bool>(key: 'isFirstLaunch');
        return result.value;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }

  bool get isUserOpen => _authManagar.authOperation.user != null;

  Future<void> launchState(
    BuildContext context,
    SplashStateEnum splashState,
  ) async {
    final route = AutoRouter.of(context);
    switch (splashState) {
      case SplashStateEnum.NO_NETWORK:
        return;
      case SplashStateEnum.FIRST_LAUNCH:
        await route.replacePath(PagePathConstant.onboard);

      case SplashStateEnum.RETURNIG_USER:
        await ProductConfigureItems.profile.reload;
        await route.replacePath(
          PagePathConstant.home,
        );

      case SplashStateEnum.NEW_USER:
        await route.replacePath(PagePathConstant.signIn);
    }
  }
}
