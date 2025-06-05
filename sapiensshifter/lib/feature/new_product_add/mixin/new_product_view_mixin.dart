import 'package:firebase_storage_module/firebase_storage_module.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/new_product_add/view/new_product_add_view.dart';
import 'package:sapiensshifter/feature/new_product_add/view_model/new_product_view_model.dart';
import 'package:sapiensshifter/feature/new_product_add/view_model/state/new_product_state.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:uuid/v7.dart';

mixin NewProductViewMixin on BaseState<NewProductAddView> {
  late final NewProductViewModel _newProductViewModel;
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ProductImageState> productImageKey;

  NewProductViewModel get viewModel => _newProductViewModel;

  void _resetForm() {
    productImageKey.currentState?.resetImage();
    formKey.currentState?.reset();
    _newProductViewModel.resetProduct();
  }

  @override
  void initState() {
    productImageKey = GlobalKey<ProductImageState>();
    formKey = GlobalKey<FormState>();

    _newProductViewModel = NewProductViewModel(
      NewProductState.initial(id: const UuidV7().generate()),
      networkManager: ProductConfigureItems.networkManager,
      storageManager: FirebaseStorageManager(
        storageOperation: FirebaseStorageOperation.instance,
      ),
    );

    _newProductViewModel.getOptions();
    super.initState();
  }

  Future<void> confirmProduct({required ProductModel product}) async {
    final validate = formKey.currentState?.validate();
    if (validate != null && validate) {
      _newProductViewModel.productEdit(product: product);
      final result = await _newProductViewModel.uploadProduct();
      _resetForm();
      _sncakBarNotificaton(result);
    }
  }

  void _sncakBarNotificaton(bool result) {
    final resultText = result
        ? LocaleKeys.page_new_product_add_suscess_product.tr()
        : LocaleKeys.page_new_product_add_failed_product.tr();
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(resultText)));
    }
  }
}
