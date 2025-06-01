import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';

class ChatPreviewState {
  const ChatPreviewState({
    required this.isLoading,
    required this.chatPreviews,
    required this.filteredChats,
    required this.userPreviewList,
  });

  factory ChatPreviewState.initial() {
    return const ChatPreviewState(
      isLoading: false,
      chatPreviews: [],
      filteredChats: [],
      userPreviewList: [],
    );
  }

  final bool isLoading;
  final List<ChatModel> chatPreviews;
  final List<ChatModel> filteredChats;
  final List<UserPreviewModel> userPreviewList;

  ChatPreviewState copyWith({
    bool? isLoading,
    List<ChatModel>? chatPreviews,
    List<ChatModel>? filteredChats,
    List<UserPreviewModel>? userPreviewList,
  }) {
    return ChatPreviewState(
      isLoading: isLoading ?? this.isLoading,
      chatPreviews: chatPreviews ?? this.chatPreviews,
      filteredChats: filteredChats ?? this.filteredChats,
      userPreviewList: userPreviewList ?? this.userPreviewList,
    );
  }
}
