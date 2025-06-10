part of '../menu_view.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBar({
    required this.title,
    required this.onSelected,
    super.key,
  });

  final String? title;
  final void Function(String? categoryId) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuViewModel, MenuViewState>(
      builder: (context, state) => AppBar(
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.none,
        title: Text(title ?? StringConstant.nullString.tr()),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(24.sp),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.sized.lowValue),
            child: state.isLoadingCategories
                ? const ShimmerCategoryChip()
                : _buildCategorys(state),
          ),
        ),
      ),
    );
  }

  CategoryChoiceChip _buildCategorys(MenuViewState state) {
    return CategoryChoiceChip(
      categories: state.categories,
      onChange: onSelected,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 24.sp);
}
