part of '../register_view.dart';

class RegisterInputForm extends StatelessWidget {
  const RegisterInputForm({
    required this.userName,
    required this.email,
    required this.password,
    required this.formState,
    super.key,
  });

  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: SeparatorListWidget(
        mainAxisSize: MainAxisSize.min,
        separator: context.sized.emptySizedHeightBoxLow,
        children: [
          SapiTextField(
            hintText: LocaleKeys.page_sign_username.tr(),
            textInputAction: TextInputAction.next,
            controller: userName,
          ),
          SapiTextField(
            validator: FormValidator.emailValidator,
            hintText: LocaleKeys.page_sign_email.tr(),
            controller: email,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
          ),
          SapiTextField(
            validator: FormValidator.passwordValidator,
            hintText: LocaleKeys.page_sign_password.tr(),
            controller: password,
            isPassword: true,
            autofillHints: const [AutofillHints.password],
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
