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
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Plase Email';
              }
              if (!text.ext.isValidEmail) {
                return 'bu email değil kral düzelt';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: email,
            autofillHints: const [AutofillHints.email],
          ),
          context.sized.emptySizedHeightBoxLow,
          SapiTextField(
            keyboardType: TextInputType.visiblePassword,
            controller: password,
            isPassword: true,
            autofillHints: const [AutofillHints.password],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              onPressed: recoveryPassword,
              child: Text(
                LocaleKeys.page_sign_sign_in_recovery_password.tr(),
                style: context.general.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
