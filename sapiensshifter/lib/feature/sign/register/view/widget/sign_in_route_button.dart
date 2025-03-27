part of '../register_view.dart';

class SignInRouteButton extends StatelessWidget {
  const SignInRouteButton({required this.onPress, super.key});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      child: RichText(
        text: TextSpan(
          text: LocaleKeys.page_sign_register_member.tr(),
          style: TextStyle(
            color: context.general.colorScheme.onPrimary,
          ),
          children: [
            TextSpan(
              text: LocaleKeys.page_sign_register_sign_in.tr(),
              style: const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
