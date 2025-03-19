import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/model/onboard_content_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/state/onboard_state.dart';

final class OnboardViewModel extends BaseCubit<OnboardState> {
  OnboardViewModel(
    super.initialState, {
    required ILocalCacheManager localCacheManager,
    required this.contentList,
  }) : _localCacheManager = localCacheManager;

  final ILocalCacheManager _localCacheManager;
  final List<OnboardContentModel> contentList;

  void pageChanged(int newPage) {
    final clampIndex = newPage.clamp(0, contentList.length);
    emit(state.copyWith(currentIndex: clampIndex));
  }

  void nextPage() {
    pageChanged(state.currentIndex + 1);
  }

  void previousPage() {
    pageChanged(state.currentIndex - 1);
  }

  Future<bool> writeFirstLaunch(BuildContext context) async {
    return ErrorUtil.runWithErrorHandling(
      action: () => _localCacheManager.cacheOperation
          .write<bool>(key: 'isFirstLaunch', value: true),
      errorHandler: UIErrorHandler(context),
      fallbackValue: false,
    );
  }
}
