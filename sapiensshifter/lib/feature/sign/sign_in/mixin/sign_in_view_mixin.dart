import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:sapiensshifter/core/constant/image_path_constant.dart';
import 'package:sapiensshifter/core/constant/page_path_constant.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/sign_in/model/social_button_model.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view_model/sign_in_view_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

mixin SignInViewMixin on BaseState<SignInView> {
  late final SignInViewModel _signInViewModel;

  SignInViewModel get viewModel => _signInViewModel;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final GlobalKey<FormState> formState;

  late final List<SocialButtonModel> socialButtonList;

  @override
  void initState() {
    // View Model
    _signInViewModel =
        SignInViewModel(authManager: FirebaseAuthManagar.instance);

    // TextEditing
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    formState = GlobalKey<FormState>();
    // List
    socialButtonList = [
      SocialButtonModel(
        path: ImagePathConstant.social_apple,
        onPress: () async {
          final result = await _signInViewModel.signInWithCredential(
            signCredential: await AppleSignCredential().call(),
          );
          if (result) await goHome();
        },
      ),
      SocialButtonModel(
        path: ImagePathConstant.social_google,
        onPress: () async {
          final result = await _signInViewModel.signInWithCredential(
            signCredential: await GoogleSignCredential().call(),
          );
          if (result) await goHome();
        },
      ),
    ];
    super.initState();
  }

  Future<void> signIn() async {
    if (formState.currentState?.validate() ?? false) {
      await viewModel.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      await goHome();
    }
  }

  Future<void> goHome() async {
    if (mounted) {
      await context.router.replaceNamed(
        PagePathConstant.home.sapiExt.withParams({'pageIndex': 1})!,
      );
    }
  }

  void routeRegisterPage() {
    context.router.replaceNamed(PagePathConstant.register);
  }

  void recoveryPassword() {
    if (formState.currentState?.validate() ?? false) {
      _signInViewModel.recoveryPassword(
        email: emailTextController.text,
      );
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
