import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

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
        final result =
            await _localCahce.cacheOperation.getValue<bool>(key: 'isFirstOpen');
        return result.value;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }

  bool get isUserOpen => _authManagar.authOperation.user != null;
}
