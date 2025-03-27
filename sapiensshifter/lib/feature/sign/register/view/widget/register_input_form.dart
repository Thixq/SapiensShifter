part of '../register_view.dart';

class RegisterInputForm extends StatelessWidget {
  const RegisterInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SeparatorColumn(
        mainAxisSize: MainAxisSize.min,
        separator: context.sized.emptySizedHeightBoxLow,
        children: [
          SapiTextField(
            hintText: LocaleKeys.page_sign_username.tr(),
          ),
          SapiTextField(
            hintText: LocaleKeys.page_sign_email.tr(),
          ),
          SapiTextField(hintText: LocaleKeys.page_sign_password.tr()),
        ],
      ),
    );
  }
}
