import 'package:core/core.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:firebase_storage_module/firebase_storage_module.dart';
import 'package:get_it/get_it.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/notification/notification_token_manager/notification_token_manager.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/shift_manager/shift_manager.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class AppDependency {
  const AppDependency._();
  static final _getIt = GetIt.I;

  static Future<void> setup() async {
    _getIt
      ..registerSingletonAsync<INetworkManager>(
        () async => FirebaseFirestoreManager.instance,
      )
      ..registerSingletonAsync<IAuthManager>(
        () async => FirebaseAuthManagar.instance,
      )
      ..registerSingleton<ILocalCacheManager>(
        SharedPreferencesManager.instace,
      )
      ..registerSingletonAsync(
        () async => Profile.instance(
          networkManager: ProductConfigureItems.networkManager,
          authManager: ProductConfigureItems.authManager,
          storageManager: FirebaseStorageManager.instance,
        ),
        dependsOn: [INetworkManager, IAuthManager],
      )
      ..registerSingletonAsync(
        () async => ShiftManager.instanceFor(
          profile: ProductConfigureItems.profile,
          networkManager: ProductConfigureItems.networkManager,
        ),
        dependsOn: [INetworkManager, Profile],
      )
      ..registerSingletonAsync<NotificationTokenManager>(
        () async => NotificationTokenManager(
          localCacheManager: ProductConfigureItems.sharedPreferencesOperation,
          networkManager: ProductConfigureItems.networkManager,
          profile: ProductConfigureItems.profile,
        ),
        dependsOn: [INetworkManager, IAuthManager, Profile],
      )
      ..registerLazySingleton<ProductViewModel>(
        ProductViewModel.new,
      );
  }

  /// read your dependency item for [AppDependency]
  static T read<T extends Object>() => _getIt<T>();
}
