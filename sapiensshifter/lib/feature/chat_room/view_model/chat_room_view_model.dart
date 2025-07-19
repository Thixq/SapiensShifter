import 'dart:async';
import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_room_models/chat_info.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/utils/chat_error_type.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_meta_data.dart';
import 'package:sapiensshifter/product/models/chats_model/message.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:uuid/v7.dart';

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

  late final ChatInfo? _currentChatInfo;
  late final String? _currentChatId;

  final INetworkManager _networkManager;
  final Profile _profile;
  StreamSubscription<List<Message>>? _messagesStreamSubscription;

  Future<void> _initializeChat() async {
    final initalState = state;

    if (initalState is ChatWithIdState) {
      _currentChatId = initalState.chatId;
      _currentChatInfo = await _loadChatInfo(chatId: _currentChatId);
      await _loadAndListenMessages();
    } else if (initalState is ChatWithModelState) {
      _currentChatInfo = initalState.chatInfo;
      _currentChatId = initalState.chatMetadata?.id;
      emit(initalState);
    }
  }

  Future<ChatInfo?> _loadChatInfo({String? chatId}) async {
    if (chatId == null || chatId.isEmpty) {
      emit(const ChatError(ChatErrorType.invalidId));
      return null;
    }
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final String? chatName;
        final String? chatPhotoUrl;
        final chatModel =
            await _networkManager.networkOperation.getItem<ChatMetadata>(
          path: '${QueryPathConstant.chatPreviewColPath}/$chatId',
          model: ChatMetadata(),
        );
        final otherUserPreviewId = chatModel.getOhterUserId(
          _profile.user?.userPreviewId,
        );
        if (chatModel.isGroup) {
          chatName = chatModel.groupName;
          chatPhotoUrl = chatModel.groupImageUrl;
        } else {
          final otherUserPreview =
              await _networkManager.networkOperation.getItem<UserPreviewModel>(
            path:
                '${QueryPathConstant.usersPreviewColPath}/$otherUserPreviewId',
            model: UserPreviewModel(),
          );
          chatName = otherUserPreview.name;
          chatPhotoUrl = otherUserPreview.photoUrl;
        }

        return ChatInfo(
          chatName: chatName,
          chatImageUrl: chatPhotoUrl,
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        emit(const ChatError(ChatErrorType.loadFailed));
        return null;
      },
    );
  }

  Future<void> _loadAndListenMessages() async {
    await _messagesStreamSubscription?.cancel();
    emit(ChatLoading());
    final chatId = _currentChatId;
    if (chatId == null || chatId.isEmpty) {
      emit(const ChatError(ChatErrorType.invalidId));
      return;
    }
    await ErrorUtil.runWithErrorHandlingAsync(
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
                  chatId: _currentChatId,
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

  Stream<List<Message>> _listenForMessages({String? chatId}) {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'timeStamp', descending: true)],
    );

    final messagesStream =
        _networkManager.networkOperation.getStreamQuery<Message>(
      path: QueryPathConstant.messagesColPath(chatId),
      query: query,
      model: Message(),
    );
    return messagesStream;
  }

  Future<void> sendMessage({required String text}) async {
    final currentState = state;
    final currentUserPreviewId = _profile.user?.userPreviewId;
    final chatId = _currentChatId;

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
            return _buildMessageWrites(
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
            transaction.set(path: path, item: currentState.chatMetadata!);
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
        await _loadAndListenMessages();
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
