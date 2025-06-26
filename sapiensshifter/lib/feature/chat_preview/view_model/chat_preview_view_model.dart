import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class ChatPreviewViewModel extends BaseCubit<ChatPreviewState> {
  ChatPreviewViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  late final StreamSubscription<SapiensUser> _streamSubscription;

  void initial() {
    getUserPreviewList();
    getStreamPrewViewList();
  }

  void getStreamPrewViewList() {
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final userId = _profile.user?.id;
        final streamChatPreviewList = _getStream(
          path: '${QueryPathConstant.usersColPath}/$userId',
          model: const SapiensUser(),
        );
        _streamSubscription = streamChatPreviewList.listen(
          (event) async {
            final result = <ChatModel>[];
            if (event.chatPreviewIdList.ext.isNotNullOrEmpty) {
              result.addAll(
                await _getPreviewList(previewList: event.chatPreviewIdList),
              );
            }

            emit(
              state.copyWith(
                isLoading: false,
                chatPreviews: result,
              ),
            );
          },
        );
      },
      fallbackValue: () async {
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

  Stream<T> _getStream<T extends IBaseModel<T>>({
    required String path,
    required T model,
  }) {
    return _networkManager.networkOperation.getStream<T>(
      path: path,
      model: model,
    );
  }

  Future<List<ChatModel>> _getPreviewList({
    required List<String>? previewList,
  }) async {
    final query = FirebaseFirestoreCustomQuery(
      filters: [
        FilterCondition(
          field: 'id',
          value: previewList,
          operator: FilterOperator.whereIn,
        ),
      ],
    );
    final result = await _networkManager.networkOperation.getItemsQuery(
      query: query,
      path: QueryPathConstant.chatPreviewColPath,
      model: ChatModel(),
    );
    result.sort((a, b) {
      return b.lastMessageTime!.compareTo(a.lastMessageTime!);
    });
    return result;
  }

  void chatSearch(String query) {
    final result = _searchFilter(query);
    emit(state.copyWith(filteredChats: result));
  }

  List<ChatModel> _searchFilter(String query) {
    if (query.trim().isEmpty) return [];

    final queryLowerCase = query.toLowerCase();
    final currentUserId = _profile.user?.userPreviewId;
    final userPreviewMap = {
      for (final user in state.userPreviewList)
        user.id: user.name?.toLowerCase() ?? '',
    };

    return state.chatPreviews.where((chat) {
      if (chat.isGroup) {
        final groupName = chat.groupName?.toLowerCase();
        return groupName != null && groupName.contains(queryLowerCase);
      } else {
        final members = chat.members ?? <String>[];
        for (final member in members) {
          if (member == currentUserId) continue;
          final memberName = userPreviewMap[member];
          if (memberName != null && memberName.contains(queryLowerCase)) {
            return true;
          }
        }
        return false;
      }
    }).toList();
  }

  void deleteChat(String chatId) {
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation.update(
          path: '${QueryPathConstant.usersColPath}/${_profile.user?.id}',
          value: {
            'chatPreviewIdList': ArrayRemoveOperation([chatId]),
          },
        );
        if (result) {
          emit(
            state.copyWith(
              chatPreviews: state.chatPreviews
                  .where((element) => element.id != chatId)
                  .toList(),
            ),
          );
        }
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        emit(
          state.copyWith(chatPreviews: [...state.chatPreviews]),
        );
        return null;
      },
    );
  }

  void getUserPreviewList() {
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.usersPreviewColPath,
          model: UserPreviewModel(),
        );
        final currentUserOut = result
            .where(
              (element) => element.id != _profile.user?.userPreviewId,
            )
            .toList();
        emit(state.copyWith(userPreviewList: currentUserOut));
      },
      fallbackValue: () async {
        emit(state.copyWith(userPreviewList: []));
      },
    );
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
