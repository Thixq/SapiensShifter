part of '../sign_in_view.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.onPress,
    super.key,
  });

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: SapiButton(
        buttonText: 'Sign In',
        onPressed: onPress,
      ),
    );
  }
}
