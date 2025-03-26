part of '../sign_in_view.dart';

class RegisterRouteButton extends StatelessWidget {
  const RegisterRouteButton({
    required this.onPress,
    super.key,
  });

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      child: RichText(
        text: TextSpan(
          text: LocaleKeys.page_sign_sign_in_not_a_member.tr(),
          style: TextStyle(
            color: context.general.colorScheme.onPrimary,
          ),
          children: [
            TextSpan(
              text: LocaleKeys.page_sign_sign_in_register_now.tr(),
              style: const TextStyle(color: CupertinoColors.activeBlue),
            ),
          ],
        ),
      ),
    );
  }
}
