part of '../shift_view.dart';

class ShiftViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShiftViewAppBar({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.page_shift_shift.tr()),
      actionsPadding: EdgeInsets.only(right: context.sized.normalValue),
      actions: [
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () {
            // TODO(kaan): go Profile view
            print('object');
          },
          child: CustomCircleAvatar(
            radius: kToolbarHeight,
            imageUrl: '${profile.user?.imagePath}',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
