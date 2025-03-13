import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class ProductConfigureItems {
  const ProductConfigureItems._();
  static FirebaseAuthManagar get firebaseAuthManager =>
      AppDependency.read<FirebaseAuthManagar>();
  static FirebaseFirestoreManager get firebaseFirestoreManager =>
      AppDependency.read<FirebaseFirestoreManager>();
  static SharedPreferencesOperation get sharedPreferencesOperation =>
      AppDependency.read<SharedPreferencesOperation>();
  static ProductViewModel get productViewModel =>
      AppDependency.read<ProductViewModel>();
}
