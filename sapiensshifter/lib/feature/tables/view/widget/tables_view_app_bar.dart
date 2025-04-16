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
      title: Text(profile?.user?.toDayBranch ?? ''),
      actionsPadding: EdgeInsets.only(right: context.sized.normalValue),
      actions: [
        Row(
          children: [
            Text(profile?.user?.name ?? ''),
            context.sized.emptySizedWidthBoxLow3x,
            InkWell(
              onTap: () {},
              child: CustomCircleAvatar(
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
