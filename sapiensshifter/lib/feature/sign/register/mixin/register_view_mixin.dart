import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/sign/register/view/register_view.dart';
import 'package:sapiensshifter/feature/sign/register/view_model/register_view_model.dart';

mixin RegisterViewMixin on BaseState<RegisterView> {
  late final RegisterViewModel _registerViewModel;
  RegisterViewModel get viewModel => _registerViewModel;

  late final TextEditingController userNameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final GlobalKey<FormState> formState;

  void routeSignIn() {
    context.router.replaceNamed('/sign/signin/');
  }

  void register() {
    if (formState.currentState?.validate() ?? false) {
      _registerViewModel.registerWithEmailAndPassword(
        name: userNameTextController.text,
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    }
  }

  @override
  void initState() {
    _registerViewModel = RegisterViewModel(FirebaseAuthManagar.instance);
    userNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    formState = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    userNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
