part of '../tables_view.dart';

class TablesViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TablesViewAppBar({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text('Kanyon'),
      actionsPadding: EdgeInsets.only(right: context.sized.normalValue),
      actions: [
        Row(
          children: [
            const Text('kaan'),
            context.sized.emptySizedWidthBoxLow3x,
            InkWell(
              onTap: () {},
              child: const CustomCircleAvatar(
                imageUrl: 'https://cataas.com/cat',
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
