import 'package:core/core.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:get_it/get_it.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class AppDependency {
  static final _getIt = GetIt.I;

  static Future<void> setup() async {
    _getIt
      ..registerLazySingleton<IAuthManager>(
        () => FirebaseAuthManagar.instance,
      )
      ..registerLazySingleton<ILocalCacheOperation>(
        () => SharedPreferencesOperation.instance,
      )
      ..registerLazySingleton<FirebaseFirestoreManager>(
        () => FirebaseFirestoreManager.instance,
      );
  }
}
