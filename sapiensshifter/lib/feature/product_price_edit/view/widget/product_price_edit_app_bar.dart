part of '../product_price_edit_view.dart'; // Bu satırı yorumlayıp tek dosyada çalıştırabilirsiniz.

class ProductPriceEditAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductPriceEditAppBar({required this.onSave, super.key});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text(LocaleKeys.page_product_price_edit_product_price_edit.tr()),
      actions: [
        IconButton(
          onPressed: onSave,
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
