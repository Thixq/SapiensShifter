part of '../shift_add_view.dart';

class ShiftAddAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShiftAddAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.page_sihft_add_view_shift_add.tr()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
