part of '../register_view.dart';

class RegisterInputForm extends StatelessWidget {
  const RegisterInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SeparatorColumn(
        mainAxisSize: MainAxisSize.min,
        separator: context.sized.emptySizedHeightBoxLow,
        children: const [
          SapiTextField(
            hintText: 'Username',
          ),
          SapiTextField(
            hintText: 'E-mail',
          ),
          SapiTextField(hintText: 'Password'),
        ],
      ),
    );
  }
}
