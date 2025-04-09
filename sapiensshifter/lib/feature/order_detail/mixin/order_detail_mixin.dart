import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/order_detail_view/view/order_detail_view.dart';
import 'package:sapiensshifter/feature/order_detail_view/view_model/order_detail_view_model.dart';
import 'package:sapiensshifter/feature/order_detail_view/view_model/state/order_detail_state.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/models/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

mixin OrderDetailMixin on BaseState<OrderDetailView> {
  late final OrderDetailViewModel _detailViewModel;

  OrderDetailViewModel get viewModel => _detailViewModel;

  late List<ExtrasModel> extrasList;

  List<CustomRadioModel<DeliveryStatus>> get deliveryOptions => [
        CustomRadioModel(
          svgPath: 'assets/icon/order_status_ic/ic_here_in.svg',
          value: DeliveryStatus.HERE_IN,
        ),
        CustomRadioModel(
          svgPath: 'assets/icon/order_status_ic/ic_take_away.svg',
          value: DeliveryStatus.TAKE_AWAY,
        ),
      ];

  @override
  void initState() {
    _detailViewModel = OrderDetailViewModel(
      OrderDetailState(
        selecetedOptions: {},
        order: OrderModel(
          price: widget.product.price,
          orderName: widget.product.productName,
          imagePath: widget.product.imagePath,
        ),
      ),
      networkManager: ProductConfigureItems.firebaseFirestoreManager,
    );
    _detailViewModel.getExtras(optionsId: widget.product.productOptions);
    super.initState();
  }
}
