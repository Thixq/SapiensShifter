part of '../view/product_price_edit_view.dart';

mixin ProductPriceEditMixin on BaseState<ProductPriceEditView> {
  late final ProductPriceEditViewModel _productPriceEditViewModel;

  ProductPriceEditViewModel get viewModel => _productPriceEditViewModel;

  @override
  void initState() {
    _productPriceEditViewModel = ProductPriceEditViewModel(
      ProductPriceEditState.initial(),
      networkManager: ProductConfigureItems.networkManager,
    );
    _productPriceEditViewModel.initial();
    super.initState();
  }

  @override
  void dispose() {
    _productPriceEditViewModel.close();
    super.dispose();
  }
}
