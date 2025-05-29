part of '../tables_view.dart';

class TablesViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TablesViewAppBar({
    required this.onTap,
    this.profile,
    super.key,
  });

  final Profile? profile;
  final VoidCallback onTap;

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
              onTap: onTap,
              child: CustomCircleAvatar(
                radius: kToolbarHeight,
                imageUrl: profile?.user?.photoUrl,
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
