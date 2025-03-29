import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/register/mixin/register_view_mixin.dart';
import 'package:sapiensshifter/feature/sign/validator/form_validator.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

part './widget/register_input_form.dart';
part './widget/sign_in_route_button.dart';
part './widget/register_button.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView>
    with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.coffee_sapiens.tr()),
      ),
      body: SafeArea(
        child: Center(
          child: KeyboardDismissOnTap(
            child: Padding(
              padding: context.padding.horizontalNormal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: SizedBox.expand()),
                  RegisterInputForm(
                    formState: formState,
                    userName: userNameTextController,
                    email: emailTextController,
                    password: passwordTextController,
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  RegisterButton(
                    onPress: () async {
                      await register();
                    },
                  ),
                  const Expanded(flex: 2, child: SizedBox.expand()),
                  SignInRouteButton(
                    onPress: routeSignIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
