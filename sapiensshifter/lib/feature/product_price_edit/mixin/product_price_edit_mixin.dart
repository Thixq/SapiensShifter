import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/product_price_edit/view/product_price_edit_view.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/product_price_edit_view_model.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/state/product_price_edit_state.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

mixin ProductPriceEditMixin on BaseState<ProductPriceEditView> {
  late final ProductPriceEditViewModel _productPriceEditViewModel;

  ProductPriceEditViewModel get viewModel => _productPriceEditViewModel;

  @override
  void initState() {
    _productPriceEditViewModel = ProductPriceEditViewModel(
      ProductPriceEditState.initial(
        mainList: List.generate(
          24,
          (index) => ProductModel(
            id: 'id$index',
            price: index.toDouble(),
            imagePath: 'https://picsum.photos/200/300?random=$index',
          ),
        ),
        priceRations: {},
      ),
    );
    super.initState();
  }
}
