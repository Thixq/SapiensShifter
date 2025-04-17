part of '../tables_view.dart';

class TablesViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TablesViewAppBar({
    required this.height,
    this.profile,
    super.key,
  });

  final double height;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        profile?.user?.toDayBranch ?? LocaleKeys.null_value_null_name.tr(),
      ),
      actionsPadding: EdgeInsets.only(right: context.sized.normalValue),
      actions: [
        Row(
          children: [
            Text(profile?.user?.name ?? LocaleKeys.null_value_null_name.tr()),
            context.sized.emptySizedWidthBoxLow3x,
            InkWell(
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                // TODO(kaan): go Profile view
              },
              child: CustomCircleAvatar(
                radius: kToolbarHeight,
                imageUrl: profile?.user?.imagePath,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
