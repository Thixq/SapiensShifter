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
      widget.chatWithState,
      networkManager: ProductConfigureItems.networkManager,
      profile: userProfile,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _chatRoomViewModel.dispose();
    super.dispose();
  }
}
