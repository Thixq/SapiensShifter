part of '../menu_view.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBar({
    required this.title,
    required this.onSelected,
    super.key,
  });

  final String? title;
  final void Function(MapEntry<String, String> category) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuViewModel, MenuViewState>(
      buildWhen: (previous, current) =>
          current.categories != previous.categories,
      builder: (context, state) => AppBar(
        clipBehavior: Clip.none,
        title: Text(title ?? StringConstant.nullString.tr()),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28.sp),
          child: ChoiceChipList<String>(
            onSelected: onSelected,
            options: state.categories,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 28.sp);
}
