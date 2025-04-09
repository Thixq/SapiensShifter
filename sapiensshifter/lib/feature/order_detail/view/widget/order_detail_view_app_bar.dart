part of '../order_detail_view.dart';

class OrderDetailViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderDetailViewAppBar({this.productName, super.key});

  final String? productName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(productName ?? StringConstant.nullString.tr()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
