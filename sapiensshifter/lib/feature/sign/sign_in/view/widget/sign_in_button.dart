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
        buttonText: LocaleKeys.page_sign_sign_in_sign_in.tr(),
        onPressed: onPress,
      ),
    );
  }
}
