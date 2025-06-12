part of '../product_price_edit_view.dart'; // Bu satırı yorumlayıp tek dosyada çalıştırabilirsiniz.

class ProductPriceEditAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductPriceEditAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: const Text('Product Price Edit'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
