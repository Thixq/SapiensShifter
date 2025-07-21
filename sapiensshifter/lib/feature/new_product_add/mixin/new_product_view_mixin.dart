part of '../view/new_product_add_view.dart';

mixin NewProductViewMixin on BaseState<NewProductAddView> {
  late final NewProductViewModel _newProductViewModel;
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ProductImageState> productImageKey;

  NewProductViewModel get viewModel => _newProductViewModel;

  @override
  void initState() {
    productImageKey = GlobalKey<ProductImageState>();
    formKey = GlobalKey<FormState>();

    _newProductViewModel = NewProductViewModel(
      NewProductState.initial(id: const UuidV7().generate()),
      networkManager: ProductConfigureItems.networkManager,
      storageManager: FirebaseStorageManager.instance,
    );

    _newProductViewModel.getOptions();
    super.initState();
  }

  void _resetForm() {
    productImageKey.currentState?.resetImage();
    formKey.currentState?.reset();
    _newProductViewModel.resetProduct();
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
      showSnakeToastMessage(context, message: resultText);
    }
  }

  @override
  void dispose() {
    _newProductViewModel.close();
    super.dispose();
  }
}
