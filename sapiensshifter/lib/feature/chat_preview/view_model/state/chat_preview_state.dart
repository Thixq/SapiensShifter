import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';

class ChatPreviewState {
  const ChatPreviewState({
    required this.isLoading,
    required this.chatPreviews,
    required this.userPreviewList,
  });

  factory ChatPreviewState.initial() {
    return const ChatPreviewState(
      isLoading: false,
      chatPreviews: [],
      userPreviewList: [],
    );
  }

  final bool isLoading;
  final List<ChatPreviewModel> chatPreviews;
  final List<UserPreviewModel> userPreviewList;

  ChatPreviewState copyWith({
    bool? isLoading,
    List<ChatPreviewModel>? chatPreviews,
    List<UserPreviewModel>? userPreviewList,
  }) {
    return ChatPreviewState(
      isLoading: isLoading ?? this.isLoading,
      chatPreviews: chatPreviews ?? this.chatPreviews,
      userPreviewList: userPreviewList ?? this.userPreviewList,
    );
  }
}
