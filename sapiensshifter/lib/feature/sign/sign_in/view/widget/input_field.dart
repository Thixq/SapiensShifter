part of '../sign_in_view.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.email,
    required this.password,
    required this.recoveryPassword,
    required this.formState,
    super.key,
  });

  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback recoveryPassword;
  final GlobalKey<FormState> formState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          SapiTextField(
            hintText: LocaleKeys.page_sign_email.tr(),
            validator: FormValidator.emailValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: email,
            autofillHints: const [AutofillHints.email],
          ),
          context.sized.emptySizedHeightBoxLow,
          SapiTextField(
            hintText: LocaleKeys.page_sign_password.tr(),
            keyboardType: TextInputType.visiblePassword,
            controller: password,
            isPassword: true,
            autofillHints: const [AutofillHints.password],
          ),
          _recoveryPasswordButton(context),
        ],
      ),
    );
  }

  Align _recoveryPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
        onPressed: recoveryPassword,
        child: Text(
          LocaleKeys.page_sign_sign_in_recovery_password.tr(),
          style: context.general.textTheme.bodySmall,
        ),
      ),
    );
  }
}
