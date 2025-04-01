import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/onboard/mixin/onboard_view_mixin.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/onboard_slider.dart';
import 'package:sapiensshifter/feature/onboard/view_model/onboard_view_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/state/onboard_state.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

@RoutePage()
class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends BaseState<OnboardView> with OnboardViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onboardViewModel,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<OnboardViewModel, OnboardState>(
            listener: (context, state) {
              if (pageController.page?.round() !=
                  onboardViewModel.state.currentIndex) {
                pageController.animateToPage(
                  state.currentIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInQuart,
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: context.padding.low,
                child: OnboardSlider(
                  pageController: pageController,
                  onboardViewModel: onboardViewModel,
                  state: state,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
