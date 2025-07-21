import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/splash/view/widget/logo_svg.dart';
import 'package:sapiensshifter/feature/splash/view_model/splash_view_model.dart';
import 'package:sapiensshifter/feature/splash/view_model/state/splash_state.dart';

part '../mixin/splash_mixin.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: BlocListener<SplashViewModel, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccess) {
              context.router.replace(state.route);
            }
            if (state is SplashError) {
              showErrorDialog(
                context,
                desc: state.message,
              );
            }
          },
          child: const Center(
            child: LogoSvg(),
          ),
        ),
      ),
    );
  }
}
