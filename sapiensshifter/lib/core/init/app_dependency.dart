import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:get_it/get_it.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class AppDependency {
  const AppDependency._();
  static final _getIt = GetIt.I;

  static Future<void> setup() async {
    _getIt
      ..registerLazySingleton<FirebaseFirestoreManager>(
        () => FirebaseFirestoreManager.instance,
      )
      ..registerLazySingleton<SharedPreferencesManager>(
        () => SharedPreferencesManager(
          cacheOperation: SharedPreferencesOperation.instance,
        ),
      )
      ..registerLazySingleton<ProductViewModel>(
        ProductViewModel.new,
      );
  }

  /// read your dependency item for [AppDependency]
  static T read<T extends Object>() => _getIt<T>();
}
