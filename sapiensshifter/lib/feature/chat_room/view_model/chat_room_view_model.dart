import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class ChatRoomViewModel extends BaseCubit<ChatRoomState> {
  ChatRoomViewModel(
    super.initialState, {
    required Profile profile,
    required INetworkManager networkManager,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;
  late final StreamSubscription<List<MessageModel>> _messagesStreamSubscription;

  Future<void> withChatId({required String chatId}) async {
    await _getChatInfo(chatId: chatId);
    await _isExist(chatId: chatId);
    final ohterUserId = state.chatModel
        .getOhterUserId(currentUserId: _profile.user?.userPreviewId);
    await _getOhterUserPreview(ohterUserPreviewId: ohterUserId);
    await _getMessages(chatId: chatId);
  }

  Future<void> withChatModel({required ChatModel chatModel}) async {
    emit(state.copyWith(chatModel: chatModel));

    final ohterUserId = state.chatModel
        .getOhterUserId(currentUserId: _profile.user?.userPreviewId);
    await _getOhterUserPreview(ohterUserPreviewId: ohterUserId);
    await _getMessages(chatId: chatModel.id!);
  }

  Future<void> _isExist({required String chatId}) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation.getItem(
          path: '${QueryPathConstant.chatPreviewColPath}/$chatId',
          model: ChatModel(),
        );
        if (result.id != null) {
          emit(state.copyWith(isExist: true));
        } else {
          emit(state.copyWith(isExist: false));
        }
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => emit(state.copyWith(isExist: false)),
    );
  }

  Future<void> _getChatInfo({required String chatId}) async {
    return ErrorUtil.runWithErrorHandlingAsync<void>(
      action: () async {
        final chatModel = await _networkManager.networkOperation.getItem(
          path: '${QueryPathConstant.chatPreviewColPath}/$chatId',
          model: ChatModel(),
        );
        emit(state.copyWith(chatModel: chatModel));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _getOhterUserPreview({String? ohterUserPreviewId}) async {
    return ErrorUtil.runWithErrorHandlingAsync<void>(
      action: () async {
        final ohterUser = await _networkManager.networkOperation.getItem(
          path: '${QueryPathConstant.usersPreviewColPath}/$ohterUserPreviewId',
          model: UserPreviewModel(),
        );
        emit(state.copyWith(otherUserPreview: ohterUser));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _getMessages({required String chatId}) async {
    await _getHistoryMessages(chatId: chatId);
    await _listenLastMessage(chatId: chatId);
  }

  Future<void> _getHistoryMessages({required String chatId}) async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [
        OrderByCondition(
          field: 'timeStamp',
          descending: true,
        ),
      ],
    );

    return ErrorUtil.runWithErrorHandlingAsync<void>(
      action: () async {
        final messages = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.messagesColPath(chatId),
          model: MessageModel(),
          query: query,
        );
        emit(state.copyWith(messages: messages));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _listenLastMessage({required String chatId}) async {
    final timestampFilter =
        (state.messages != null && state.messages!.isNotEmpty)
            ? FilterCondition(
                field: 'timeStamp',
                operator: FilterOperator.isGreaterThan,
                value: state.messages!.first.toJson()['timeStamp'],
              )
            : null;

    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'timeStamp', descending: true)],
      filters: timestampFilter != null ? [timestampFilter] : [],
    );

    ErrorUtil.runWithErrorHandling<void>(
      action: () {
        final messagesStream = _networkManager.networkOperation.getStreamQuery(
          path: QueryPathConstant.messagesColPath(chatId),
          query: query,
          model: MessageModel(),
        );
        _messagesStreamSubscription = messagesStream.listen(
          (messages) {
            if (messages.isNotEmpty) {
              final newMessage = messages.first;
              state.messages?.insert(0, newMessage);
            }

            emit(state.copyWith());
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () {},
    );
  }

  Future<void> writeMessage({
    required String text,
  }) async {
    final message = MessageModel(
      senderId: _profile.user?.userPreviewId,
      text: text,
      timeStamp: DateTime.now().toUtc(),
    );
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.addItem(
          path: QueryPathConstant.messagesColPath(state.chatModel.id!),
          item: message,
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> saveChat() {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _newChatPreviewCreate();
        await _updateUserChatPreviewList();
        emit(state.copyWith(isExist: true));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _newChatPreviewCreate() async {
    await _networkManager.networkOperation.addItem(
      path: '${QueryPathConstant.chatPreviewColPath}/${state.chatModel.id}',
      item: state.chatModel,
    );
  }

  Future<void> _updateUserChatPreviewList() async {
    await _networkManager.networkOperation.update(
      path: '${QueryPathConstant.usersColPath}/${_profile.user?.id}',
      value: {
        'chatPreviewIdList': ArrayUnionOperation([state.chatModel.id]),
      },
    );
  }

  void dispose() {
    _messagesStreamSubscription.cancel();
  }
}
