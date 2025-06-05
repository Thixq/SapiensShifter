import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/onboard/view/onboard_view.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/model/onboard_content_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/onboard_view_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/state/onboard_state.dart';
import 'package:sapiensshifter/product/constant/assets_path_constant.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

mixin OnboardViewMixin on BaseState<OnboardView> {
  late final PageController pageController;
  late final OnboardViewModel _onboardViewModel;
  OnboardViewModel get onboardViewModel => _onboardViewModel;

  List<OnboardContentModel> get _initList {
    return [
      OnboardContentModel(
        imagePath: AssetsPathConstant.onboard_orderImage,
        title: LocaleKeys.page_onboard_onboard_content_content_title_order.tr(),
        desc: LocaleKeys.page_onboard_onboard_content_content_desc_order_desc
            .tr(),
      ),
      OnboardContentModel(
        imagePath: AssetsPathConstant.onboard_shiftImage,
        title: LocaleKeys.page_onboard_onboard_content_content_title_shift.tr(),
        desc: LocaleKeys.page_onboard_onboard_content_content_desc_shift_desc
            .tr(),
      ),
      OnboardContentModel(
        imagePath: AssetsPathConstant.onboard_warehouseImage,
        title: LocaleKeys.page_onboard_onboard_content_content_title_warehouse
            .tr(),
        desc: LocaleKeys
            .page_onboard_onboard_content_content_desc_warehouse_desc
            .tr(),
      ),
    ];
  }

  @override
  void initState() {
    pageController = PageController();
    _onboardViewModel = OnboardViewModel(
      OnboardState.initial(),
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
