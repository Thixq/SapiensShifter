part of '../view/chat_room_view.dart';

mixin ChatRoomViewMixin on BaseState<ChatRoomView> {
  late final ChatRoomViewModel _chatRoomViewModel;
  ChatRoomViewModel get viewModel => _chatRoomViewModel;
  Profile get userProfile => ProductConfigureItems.profile;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    _chatRoomViewModel = ChatRoomViewModel(
      _startChat,
      networkManager: ProductConfigureItems.networkManager,
      profile: userProfile,
    );
    super.initState();
  }

  ChatWithState get _startChat {
    if (widget.id != null) {
      return ChatWithIdState(chatId: widget.id);
    } else if (widget.chatWithModel != null) {
      return ChatWithModelState(
        chatInfo: widget.chatWithModel?.chatInfo,
        chatMetadata: widget.chatWithModel?.chatMetadata,
      );
    }
    return const ChatError(ChatErrorType.loadFailed);
  }

  @override
  void dispose() {
    controller.dispose();
    _chatRoomViewModel.dispose();
    super.dispose();
  }
}
