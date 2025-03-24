part of '../sign_in_view.dart';

class SignInDivider extends StatelessWidget {
  const SignInDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 32,
            indent: context.sized.normalValue,
            endIndent: context.sized.normalValue,
          ),
        ),
        const Text('ya da'),
        Expanded(
          child: Divider(
            height: 32,
            indent: context.sized.normalValue,
            endIndent: context.sized.normalValue,
          ),
        ),
      ],
    );
  }
}
