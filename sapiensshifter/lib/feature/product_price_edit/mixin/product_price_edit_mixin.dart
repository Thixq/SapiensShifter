import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/product_price_edit/view/product_price_edit_view.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/product_price_edit_view_model.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/state/product_price_edit_state.dart';

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
}
