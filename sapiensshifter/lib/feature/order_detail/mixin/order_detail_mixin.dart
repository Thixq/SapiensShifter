import 'dart:ui';

import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/order_detail/view/order_detail_view.dart';
import 'package:sapiensshifter/feature/order_detail/view_model/order_detail_view_model.dart';
import 'package:sapiensshifter/feature/order_detail/view_model/state/order_detail_state.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/constant/assets_path_constant.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';
import 'package:uuid/v7.dart';

mixin OrderDetailMixin on BaseState<OrderDetailView> {
  late final OrderDetailViewModel _detailViewModel;

  OrderDetailViewModel get viewModel => _detailViewModel;

  late List<ExtrasModel> extrasList;

  List<CustomRadioModel<DeliveryStatus>> get deliveryOptions => [
        CustomRadioModel(
          widget: SvgAssetBuilder(
            builderSize: Size(24.sp, 24.sp),
            svgPath: AssetsPathConstant.hereIn,
          ),
          value: DeliveryStatus.HERE_IN,
        ),
        CustomRadioModel(
          widget: SvgAssetBuilder(
            builderSize: Size(24.sp, 24.sp),
            svgPath: AssetsPathConstant.takeAway,
          ),
          value: DeliveryStatus.TAKE_AWAY,
        ),
      ];

  @override
  void initState() {
    _detailViewModel = OrderDetailViewModel(
      OrderDetailState.initial(
        order: OrderModel(
          id: const UuidV7().generate(),
          price: widget.product.price,
          orderName: widget.product.productName,
          imagePath: widget.product.imagePath,
        ),
      ),
      networkManager: ProductConfigureItems.networkManager,
    );
    _detailViewModel.getExtras(optionsId: widget.product.productOptions);
    super.initState();
  }
}
