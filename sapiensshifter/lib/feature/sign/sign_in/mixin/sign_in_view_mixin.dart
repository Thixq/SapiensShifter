import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:sapiensshifter/core/constant/image_path_constant.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view/model/social_button_model.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view/sign_in_view.dart';
import 'package:sapiensshifter/feature/sign/sign_in/view_model/sign_in_view_model.dart';

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
          await _signInViewModel.signInWithCredential(
            signCredential: await AppleSignCredential().call(),
          );
        },
      ),
      SocialButtonModel(
        path: ImagePathConstant.social_google,
        onPress: () async {
          await _signInViewModel.signInWithCredential(
            signCredential: await GoogleSignCredential().call(),
          );
        },
      ),
    ];
    super.initState();
  }

  void routeRegisterPage() {
    context.router.replaceNamed('/sign/register/');
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
