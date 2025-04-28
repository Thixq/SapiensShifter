import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';

class ChatPreviewState {
  const ChatPreviewState({
    required this.isLoading,
    required this.chatPreviews,
  });

  factory ChatPreviewState.initial() {
    return const ChatPreviewState(
      isLoading: false,
      chatPreviews: [],
    );
  }

  final bool isLoading;
  final List<ChatPreviewModel> chatPreviews;

  ChatPreviewState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ChatPreviewModel>? chatPreviews,
  }) {
    return ChatPreviewState(
      isLoading: isLoading ?? this.isLoading,
      chatPreviews: chatPreviews ?? this.chatPreviews,
    );
  }
}
