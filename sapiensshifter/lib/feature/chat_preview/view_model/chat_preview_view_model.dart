import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_meta_data.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class ChatPreviewViewModel extends BaseCubit<ChatPreviewState> {
  ChatPreviewViewModel(
    super.initialState, {
    required Profile profile,
    required INetworkManager networkManager,
  })  : _profile = profile,
        _networkManager = networkManager;

  final Profile _profile;
  final INetworkManager _networkManager;
  StreamSubscription<List<ChatMetadata>>? _streamSubscription;

  Future<void> initial() async {
    await getUsers();
    await getChats();
  }

  Future<void> getUsers() async {
    final currentUser = _profile.user?.userPreviewId;
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.usersPreviewColPath,
          model: UserPreviewModel(),
        );
        final withOutCurrentUser = result
            .where(
              (element) => element.id != currentUser,
            )
            .toList();
        emit(state.copyWith(allUsers: withOutCurrentUser));
      },
      fallbackValue: () async {
        emit(state.copyWith(allUsers: []));
      },
    );
  }

  void searchChatName({required String text}) {
    final currentUserId = _profile.user?.userPreviewId;
    final textLowerCase = text.toLowerCase();
    final userPreviewMap = {
      for (final user in state.allUsers) user.id: user.name?.toLowerCase(),
    };

    final searchedChat = state.chats.where(
      (chat) {
        if (chat.isGroup) {
          final groupName = chat.groupName;
          final a = groupName != null &&
              groupName.toLowerCase().contains(textLowerCase);
          return a;
        } else {
          final otherUser = chat.members?.firstWhere(
            (element) => element != currentUserId,
          );
          final otherUserName = userPreviewMap[otherUser]?.toLowerCase();

          return otherUserName != null && otherUserName.contains(textLowerCase);
        }
      },
    ).toList();
    if (searchedChat.isEmpty) {
      emit(state.copyWith(searchedChats: []));
    } else {
      emit(state.copyWith(searchedChats: searchedChat));
    }
  }

  Future<void> softDeleteChat({String? chatId}) async {
    final currentUserId = _profile.user?.userPreviewId;

    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.update(
          path: '${QueryPathConstant.chatPreviewColPath}/$chatId',
          value: {
            'members': ArrayRemoveOperation([currentUserId]),
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> getChats() async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        _streamSubscription = _getChatsStream.listen(
          (event) {
            emit(state.copyWith(chats: event));
          },
        );
      },
      fallbackValue: () async {
        emit(state.copyWith(chats: []));
      },
    );
  }

  Stream<List<ChatMetadata>> get _getChatsStream {
    final currentUser = _profile.user?.userPreviewId;
    final query = FirebaseFirestoreCustomQuery(
      filters: [
        FilterCondition(
          field: 'members',
          value: currentUser,
          operator: FilterOperator.arrayContains,
        ),
      ],
      orderBy: [
        OrderByCondition(field: 'lastMessage.timeStamp', descending: true),
      ],
    );
    return _networkManager.networkOperation.getStreamQuery(
      path: QueryPathConstant.chatPreviewColPath,
      model: ChatMetadata(),
      query: query,
    );
  }

  void dispose() {
    _streamSubscription?.cancel();
    super.close();
  }
}
