import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:sapiensshifter/core/constant/assets_path_constant.dart';
import 'package:sapiensshifter/core/constant/page_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/sign_in/model/social_button_model.dart';
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
    _signInViewModel = SignInViewModel(
      authManager: ProductConfigureItems.authManager,
      profile: ProductConfigureItems.profile,
    );

    // TextEditing
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    formState = GlobalKey<FormState>();
    // List
    socialButtonList = [
      SocialButtonModel(
        path: AssetsPathConstant.social_apple,
        onPress: () async {
          await ErrorUtil.runWithErrorHandlingAsync(
            action: () async {
              final result = await _signInViewModel.signInWithCredential(
                signCredential: await AppleSignCredential().call(),
              );
              if (result) {
                await getProfile;
                await _goHome();
              }
            },
            errorHandler: ServiceErrorHandler(),
            fallbackValue: () async {},
          );
        },
      ),
      SocialButtonModel(
        path: AssetsPathConstant.social_google,
        onPress: () async {
          await ErrorUtil.runWithErrorHandlingAsync(
            action: () async {
              final result = await _signInViewModel.signInWithCredential(
                signCredential: await GoogleSignCredential().call(),
              );
              if (result) {
                await getProfile;
                await _goHome();
              }
            },
            errorHandler: ServiceErrorHandler(),
            fallbackValue: () async {},
          );
        },
      ),
    ];
    super.initState();
  }

  Future<void> signIn() async {
    if (formState.currentState?.validate() ?? false) {
      final result = await viewModel.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
        context: context,
      );
      if (result) {
        await getProfile;
        await _goHome();
      }
    }
  }

  Future<void> get getProfile async {
    await ProductConfigureItems.profile.reload;
  }

  Future<void> _goHome() async {
    if (mounted) {
      await context.router.replacePath(
        PagePathConstant.home,
      );
    }
  }

  void routeRegisterPage() {
    context.router.replacePath(PagePathConstant.register);
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
