import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class ChatPreviewViewModel extends BaseCubit<ChatPreviewState> {
  ChatPreviewViewModel(
    super.initialState, {
    required INetworkManager iNetworkManager,
    required Profile profile,
  })  : _iNetworkManager = iNetworkManager,
        _profile = profile;

  final INetworkManager _iNetworkManager;
  final Profile _profile;

  void getPreviewList() {
    emit(state.copyWith(isLoading: true));
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final chatPreviewList = _profile.user?.chatPreviewIdList;
        final query = FirebaseFirestoreCustomQuery(
          filters: [
            FilterCondition(
              field: 'id',
              value: chatPreviewList,
              operator: FilterOperator.whereIn,
            ),
          ],
        );
        final result = await _iNetworkManager.networkOperation.getItemsQuery(
          query: query,
          path: QueryPathConstant.chatPreviewColPath,
          model: ChatPreviewModel(),
        );
        emit(
          state.copyWith(
            isLoading: false,
            chatPreviews: result,
          ),
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: null,
    );
  }
}
