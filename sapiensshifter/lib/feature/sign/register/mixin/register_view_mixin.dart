import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/constant/page_path_constant.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
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
    context.router.replacePath('/sign/signin/');
  }

  Future<void> register() async {
    if (formState.currentState?.validate() ?? false) {
      final result = await _registerViewModel.registerWithEmailAndPassword(
        name: userNameTextController.text,
        email: emailTextController.text,
        password: passwordTextController.text,
        context: context,
      );
      if (result) {
        await _goHome();
      }
    }
  }

  Future<void> _goHome() async {
    if (mounted) {
      await context.router.replacePath(
        PagePathConstant.home,
      );
    }
  }

  @override
  void initState() {
    _registerViewModel = RegisterViewModel(
      ProductConfigureItems.authManager,
      ProductConfigureItems.networkManager,
    );
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
