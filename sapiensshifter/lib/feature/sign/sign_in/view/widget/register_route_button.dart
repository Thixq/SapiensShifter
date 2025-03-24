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
          text: 'Not a member?',
          style: TextStyle(
            color: context.general.colorScheme.onPrimary,
          ),
          children: const [
            TextSpan(
              text: 'Register Now!',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ],
        ),
      ),
    );
  }
}
