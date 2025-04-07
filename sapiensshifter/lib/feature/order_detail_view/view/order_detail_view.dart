import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart'
    show ImageBuilder;

part './widget/order_detail_view_app_bar.dart';

@RoutePage()
class OrderDetailView extends StatefulWidget {
  const OrderDetailView({required this.product, super.key});

  final ProductModel product;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderDetailViewAppBar(
        productName: widget.product.productName,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(
                    height: 56.sp,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ImageBuilder(
                        borderRadius: BorderRadius.circular(32),
                        fit: BoxFit.none,
                        imageUrl: widget.product.imagePath,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.description ??
                        StringConstant.nullString.tr(),
                    style: context.general.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.deepPurpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}
