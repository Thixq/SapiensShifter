// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';

final class ChatRoomState {
  final UserPreviewModel? otherUserPreview;
  final ChatModel chatModel;
  final bool isExist;
  final List<MessageModel>? messages;
  ChatRoomState({
    required this.chatModel,
    this.otherUserPreview,
    this.messages,
    this.isExist = false,
  });

  factory ChatRoomState.initial() {
    return ChatRoomState(
      otherUserPreview: UserPreviewModel(),
      chatModel: ChatModel(),
      messages: [],
    );
  }

  ChatRoomState copyWith({
    UserPreviewModel? otherUserPreview,
    ChatModel? chatModel,
    List<MessageModel>? messages,
    bool? isExist,
  }) {
    return ChatRoomState(
      otherUserPreview: otherUserPreview ?? this.otherUserPreview,
      chatModel: chatModel ?? this.chatModel,
      messages: messages ?? this.messages,
      isExist: isExist ?? this.isExist,
    );
  }
}
