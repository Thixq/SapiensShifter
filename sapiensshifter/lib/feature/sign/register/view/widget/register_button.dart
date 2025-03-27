part of '../register_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({required this.onPress, super.key});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: SapiButton(
        buttonText: LocaleKeys.page_sign_register_registerText.tr(),
        onPressed: onPress,
      ),
    );
  }
}
