import 'dart:async';

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
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  late final StreamSubscription<List<ChatPreviewModel>> _streamSubscription;

  void getStreamPrewViewList() {
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final streamList = _getStream(
          path: QueryPathConstant.chatPreviewColPath,
          model: ChatPreviewModel(),
        );

        _streamSubscription = streamList.listen(
          (event) => emit(
            state.copyWith(chatPreviews: [...event]),
          ),
        );
      },
      fallbackValue: () {},
    );
  }

  Stream<List<T>> _getStream<T extends IBaseModel<T>>({
    required String path,
    required T model,
  }) async* {
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
    yield* _networkManager.networkOperation.getStreamQuery<T>(
      path: path,
      model: model,
      query: query,
    );
  }

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
        final result = await _networkManager.networkOperation.getItemsQuery(
          query: query,
          path: QueryPathConstant.chatPreviewColPath,
          model: ChatPreviewModel(),
        );
        result.sort((a, b) {
          return b.lastMessageTime!.compareTo(a.lastMessageTime!);
        });
        emit(
          state.copyWith(
            isLoading: false,
            chatPreviews: result,
          ),
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () {
        emit(
          state.copyWith(
            isLoading: false,
            chatPreviews: [],
          ),
        );
        return null;
      },
    );
  }

  void deleteChat(String chatPrewviewId) {
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation.update(
          path: '${QueryPathConstant.usersColPath}/${_profile.user?.id}',
          value: {
            'chatPreviewIdList': ArrayRemoveOperation([chatPrewviewId]),
          },
        );
        if (result) {
          emit(
            state.copyWith(
              chatPreviews: state.chatPreviews
                  .where((element) => element.id != chatPrewviewId)
                  .toList(),
            ),
          );
        }
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () {
        emit(
          state.copyWith(chatPreviews: [...state.chatPreviews]),
        );
        return null;
      },
    );
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
