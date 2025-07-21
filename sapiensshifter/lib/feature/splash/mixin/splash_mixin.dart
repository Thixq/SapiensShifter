part of '../view/splash_view.dart';

mixin SplashViewMixin on BaseState<SplashView> {
  late final SplashViewModel _splashViewModel;
  SplashViewModel get viewModel => _splashViewModel;

  @override
  void initState() {
    super.initState();
    _splashViewModel = SplashViewModel(
      authManager: ProductConfigureItems.authManager,
      localCahce: ProductConfigureItems.sharedPreferences,
      connectivityService: ProductConfigureItems.connectivityService,
    );
    _splashViewModel.initializeAndDetermineRoute();
  }

  @override
  void dispose() {
    _splashViewModel.close();
    super.dispose();
  }
}
