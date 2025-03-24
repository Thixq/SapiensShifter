part of '../sign_in_view.dart';

class SignInAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SignInAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Coffee Sapiens'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
