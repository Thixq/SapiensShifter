import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/exceptions/network_disable_excepiton.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';

import 'package:sapiensshifter/feature/splash/view_model/state/splash_state.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class SplashViewModel extends BaseCubit<SplashState> {
  SplashViewModel({
    required ILocalCacheManager localCahce,
    required IAuthManager authManager,
    required IConnectivityService connectivityService,
  })  : _authManagar = authManager,
        _localCahce = localCahce,
        _connectivityService = connectivityService,
        super(SplashInitial());
  final ILocalCacheManager _localCahce;
  final IAuthManager _authManagar;
  final IConnectivityService _connectivityService;

  Future<bool> get _isFirstOpen async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _localCahce.cacheOperation
            .getValue<bool>(key: StringConstant.isFirstLaunchKey);
        return result.value;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => true,
    );
  }

  bool get _isUserOpen => _authManagar.authOperation.user != null;

  Future<void> initializeAndDetermineRoute() async {
    try {
      await ErrorUtil.runAndRethrowAsync<void>(
        action: () async {
          await _connectivityService.checkNetworkConnection();

          final PageRouteInfo nextRoute;
          if (await _isFirstOpen) {
            nextRoute = const OnboardRoute();
          } else if (_isUserOpen) {
            await ProductConfigureItems.profile.reload;
            nextRoute = const HomeRoute();
          } else {
            nextRoute = const SignInRoute();
          }

          emit(SplashSuccess(route: nextRoute));
        },
      );
    } on NetworkExcepiton catch (e) {
      emit(SplashError(message: e.message));
    } catch (e) {
      emit(
        SplashError(
          message: LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': e.toString()}),
        ),
      );
    }
  }
}
