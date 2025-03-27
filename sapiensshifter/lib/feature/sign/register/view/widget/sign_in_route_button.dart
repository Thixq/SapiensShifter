part of '../register_view.dart';

class SignInRouteButton extends StatelessWidget {
  const SignInRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      child: RichText(
        text: TextSpan(
          text: 'Üye misiniz?',
          style: TextStyle(
            color: context.general.colorScheme.onPrimary,
          ),
          children: const [
            TextSpan(
              text: 'Giriş yapın!',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
