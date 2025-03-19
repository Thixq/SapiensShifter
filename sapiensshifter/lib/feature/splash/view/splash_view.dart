import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/splash/mixin/splash_mixin.dart';
import 'package:sapiensshifter/feature/splash/view/widget/logo_svg.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LogoSvg(),
      ),
    );
  }
}
