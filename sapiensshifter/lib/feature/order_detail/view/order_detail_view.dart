import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/constant/assets_path_constant.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/order_detail/view_model/order_detail_view_model.dart';
import 'package:sapiensshifter/feature/order_detail/view_model/state/order_detail_state.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio_viewer.dart';
import 'package:sapiensshifter/product/component/custom_radio/decoration/custom_radio_decoration.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart'
    show ImageBuilder;
import 'package:sapiensshifter/product/utils/ui/separator_list_widget.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/v7.dart';

part 'widget/order_detail_view_app_bar.dart';
part 'widget/title_content.dart';
part 'widget/body_content.dart';
part 'widget/delivery_options.dart';
part 'widget/option_widget.dart';
part 'widget/sumbit_button.dart';
part 'widget/shimmer_options_list.dart';
part '../mixin/order_detail_mixin.dart';

@RoutePage()
class OrderDetailView extends StatefulWidget {
  const OrderDetailView({required this.product, super.key});

  final ProductModel product;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends BaseState<OrderDetailView>
    with OrderDetailMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: OrderDetailViewAppBar(
          productName: widget.product.productName,
        ),
        body: Column(
          children: [
            Title(productModel: widget.product),
            Body(
              deliveryOptions: deliveryOptions,
              deliveryChange: viewModel.changeDelivery,
              optionChange: viewModel.totalPriceAndOptionsList,
              onSumbit: () {
                final result = viewModel.sumbit;
                context.router.maybePop(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}
