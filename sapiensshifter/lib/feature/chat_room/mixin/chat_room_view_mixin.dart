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
      ChatRoomState.initial(),
      networkManager: ProductConfigureItems.networkManager,
      profile: userProfile,
    );
    chat(chatId: widget.chatId, chatModel: widget.chatModel);

    super.initState();
  }

  void chat({String? chatId, ChatModel? chatModel}) {
    if (chatId != null) {
      _chatRoomViewModel.withChatId(chatId: chatId);
    } else if (chatModel != null) {
      _chatRoomViewModel.withChatModel(chatModel: chatModel);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _chatRoomViewModel.dispose();
    super.dispose();
  }
}
