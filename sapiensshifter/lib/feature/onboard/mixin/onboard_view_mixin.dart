part of '../view/onboard_view.dart';

mixin OnboardViewMixin on BaseState<OnboardView> {
  late final PageController pageController;
  late final OnboardViewModel _onboardViewModel;
  OnboardViewModel get viewModel => _onboardViewModel;

  List<OnboardContentModel> get initList {
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
    _onboardViewModel = OnboardViewModel(
      OnboardState.initial(),
      contentList: initList,
      localCacheManager: ProductConfigureItems.sharedPreferences,
    );
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _onboardViewModel.close();
    super.dispose();
  }
}
