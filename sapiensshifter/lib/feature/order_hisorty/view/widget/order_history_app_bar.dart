part of '../order_history_view.dart';

class OrderHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.page_order_history_order_list.tr()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
