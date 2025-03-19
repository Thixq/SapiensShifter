import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/model/onboard_content_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/onboard_view_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/state/onboard_state.dart';

mixin OnboardViewMixin on BaseState<OnboardView> {
  late final PageController pageController;
  late final OnboardViewModel _onboardViewModel;
  OnboardViewModel get onboardViewModel => _onboardViewModel;

  List<OnboardContentModel> get _initList {
    return [
      OnboardContentModel(
        imagePath: 'assets/images/onboard/onboard_order_image.png',
        title: 'Sipariş Takibi',
        desc: 'Sipariş bla bla bla',
      ),
      OnboardContentModel(
        imagePath: 'assets/images/onboard/onboard_shift_image.png',
        title: 'Sipariş Takibi',
        desc: 'Sipariş bla bla bla' * 40,
      ),
    ];
  }

  @override
  void initState() {
    pageController = PageController();
    _onboardViewModel = OnboardViewModel(
      OnboardState(0),
      contentList: _initList,
      localCacheManager: ProductConfigureItems.sharedPreferencesOperation,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
