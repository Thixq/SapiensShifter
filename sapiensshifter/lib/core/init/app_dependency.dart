import 'package:core/core.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:get_it/get_it.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class AppDependency {
  const AppDependency._();
  static final _getIt = GetIt.I;

  static Future<void> setup() async {
    _getIt
      ..registerLazySingleton<INetworkManager>(
        () => FirebaseFirestoreManager.instance,
      )
      ..registerLazySingleton<IAuthManager>(
        () => FirebaseAuthManagar.instance,
      )
      ..registerSingleton<ILocalCacheManager>(
        SharedPreferencesManager.instace,
      )
      ..registerLazySingleton<ProductViewModel>(
        ProductViewModel.new,
      )
      ..registerSingletonAsync<Profile>(() async {
        return Profile.instance(
          networkManager: ProductConfigureItems.networkManager,
          authManager: ProductConfigureItems.authManager,
        );
      });
  }

  /// read your dependency item for [AppDependency]
  static T read<T extends Object>() => _getIt<T>();
}
