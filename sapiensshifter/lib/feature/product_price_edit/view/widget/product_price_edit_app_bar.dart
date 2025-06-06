part of '../product_price_edit_view.dart';

class ProductPriceEditAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductPriceEditAppBar({required this.onSave, super.key});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Product Price Edit',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: onSave,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
