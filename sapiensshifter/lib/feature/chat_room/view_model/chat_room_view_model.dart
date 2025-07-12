import 'dart:async';
import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/chat_room/model/chat_info.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/utils/chat_error_type.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

part 'utils/chat_room_utils.dart';

class ChatRoomViewModel extends BaseCubit<ChatWithState> with _ChatRoomUtils {
  ChatRoomViewModel(
    super.initialState, {
    required Profile profile,
    required INetworkManager networkManager,
  })  : _networkManager = networkManager,
        _profile = profile {
    _initializeChat();
  }

  late final ChatInfo _currentChatInfo;

  final INetworkManager _networkManager;
  final Profile _profile;
  late final StreamSubscription<List<MessageModel>>?
      _messagesStreamSubscription;

  void _initializeChat() {
    final initalState = state;

    if (initalState.chatInfo == null) {
      emit(const ChatError(ChatErrorType.infoUnavailable));
      return;
    }
    _currentChatInfo = initalState.chatInfo!;
    if (initalState is ChatWithIdState) {
      _loadAndListenMessages();
    } else if (initalState is ChatWithModelState) {
      emit(initalState);
    }
  }

  void _loadAndListenMessages() {
    _messagesStreamSubscription?.cancel();
    emit(ChatLoading());
    final chatId = _currentChatInfo.chatId;
    if (chatId == null || chatId.isEmpty) {
      emit(const ChatError(ChatErrorType.invalidId));
      return;
    }
    ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final messagesStream = _listenForMessages(chatId: chatId);
        _messagesStreamSubscription = messagesStream.listen(
          (messages) {
            final currentState = state;
            if (currentState is ChatLoaded) {
              emit(currentState.copyWith(messages: messages));
            } else {
              emit(
                ChatLoaded(
                  chatInfo: _currentChatInfo,
                  messages: messages,
                ),
              );
            }
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        emit(const ChatError(ChatErrorType.loadFailed));
        return;
      },
    );
  }

  Stream<List<MessageModel>> _listenForMessages({String? chatId}) {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'timeStamp', descending: true)],
    );

    final messagesStream =
        _networkManager.networkOperation.getStreamQuery<MessageModel>(
      path: QueryPathConstant.messagesColPath(chatId),
      query: query,
      model: MessageModel(),
    );
    return messagesStream;
  }

  Future<void> sendMessage({required String text}) async {
    final currentState = state;
    final currentUserPreviewId = _profile.user?.userPreviewId;
    final chatId = _currentChatInfo.chatId;

    if (currentUserPreviewId == null || chatId == null || chatId.isEmpty) {
      emit(const ChatError(ChatErrorType.missingInfoForSend));
      return;
    }

    if (currentState is ChatWithModelState) {
      await _chatWithModelSendMessage(
        chatId,
        currentState,
        text,
        currentUserPreviewId,
      );
    } else if (currentState is ChatLoaded) {
      await _chatLoadedSendMessage(chatId, text, currentUserPreviewId);
    }
  }

  Future<void> _chatLoadedSendMessage(
    String chatId,
    String text,
    String currentUserPreviewId,
  ) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.runBatch(
          (batch) async {
            _buildMessageWrites(
              writer: batch,
              createAction: ({
                required item,
                required path,
                required writer,
              }) =>
                  writer.create(path: path, item: item),
              updateAction: ({
                required data,
                required path,
                required writer,
              }) =>
                  writer.update(path: path, data: data),
              chatId: chatId,
              text: text,
              senderId: currentUserPreviewId,
            );
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        emit(const ChatError(ChatErrorType.sendFailed));
        return;
      },
    );
  }

  Future<void> _chatWithModelSendMessage(
    String chatId,
    ChatWithModelState currentState,
    String text,
    String currentUserPreviewId,
  ) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.runTransaction(
          (transaction) async {
            final path = '${QueryPathConstant.chatPreviewColPath}/$chatId';
            transaction.set(path: path, item: currentState.chatModel!);
            _buildMessageWrites<ITransaction>(
              writer: transaction,
              createAction: ({
                required item,
                required path,
                required writer,
              }) =>
                  writer.set(path: path, item: item),
              updateAction: ({
                required data,
                required path,
                required writer,
              }) =>
                  writer.update(path: path, data: data),
              chatId: chatId,
              text: text,
              senderId: currentUserPreviewId,
            );
          },
        );
        _loadAndListenMessages();
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        emit(const ChatError(ChatErrorType.sendFailed));
        return;
      },
    );
  }

  void dispose() {
    _messagesStreamSubscription?.cancel();
    super.close();
  }
}
