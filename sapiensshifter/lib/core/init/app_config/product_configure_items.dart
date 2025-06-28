import 'package:core/core.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/core/notification/notification_token_manager/notification_token_manager.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/shift_manager/shift_manager.dart';

class ProductConfigureItems {
  const ProductConfigureItems._();
  static INetworkManager get networkManager =>
      AppDependency.read<INetworkManager>();
  static IAuthManager get authManager => AppDependency.read<IAuthManager>();
  static ILocalCacheManager get sharedPreferencesOperation =>
      AppDependency.read<ILocalCacheManager>();
  static ProductViewModel get productViewModel =>
      AppDependency.read<ProductViewModel>();
  static Profile get profile => AppDependency.read<Profile>();
  static NotificationTokenManager get notificationTokenManager =>
      AppDependency.read<NotificationTokenManager>();
  static ShiftManager get shiftManager => AppDependency.read<ShiftManager>();
}
