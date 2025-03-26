import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/sign_in/mixin/sign_in_view_mixin.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view/model/social_button_model.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/component/sapi_text_field.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

part './widget/input_field.dart';
part './widget/register_route_button.dart';
part './widget/sign_in_appbar.dart';
part './widget/sign_in_button.dart';
part './widget/sign_in_divider.dart';
part './widget/social_sign_in_button.dart';

@RoutePage()
class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends BaseState<SignInView> with SignInViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SignInAppbar(),
      body: KeyboardDismissOnTap(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: context.padding.horizontalNormal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox.expand()),
                  InputField(
                    email: emailTextController,
                    password: passwordTextController,
                    formState: formState,
                    recoveryPassword: () {
                      formState.currentState!.validate();
                    },
                  ),
                  SignInButton(
                    onPress: () => viewModel.signInWithEmailAndPassword(
                      email: emailTextController.text,
                      password: passwordTextController.text,
                    ),
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  const SignInDivider(),
                  context.sized.emptySizedHeightBoxLow,
                  SocialSignInButtons(
                    socialButtonList: socialButtonList,
                  ),
                  const Expanded(child: SizedBox.expand()),
                  RegisterRouteButton(
                    onPress: routeRegisterPage,
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
