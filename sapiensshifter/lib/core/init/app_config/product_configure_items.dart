import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

class ProductConfigureItems {
  const ProductConfigureItems._();
  static FirebaseFirestoreManager get firebaseFirestoreManager =>
      AppDependency.read<FirebaseFirestoreManager>();
  static SharedPreferencesManager get sharedPreferencesOperation =>
      AppDependency.read<SharedPreferencesManager>();
  static ProductViewModel get productViewModel =>
      AppDependency.read<ProductViewModel>();
}
