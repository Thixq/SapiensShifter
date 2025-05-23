import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_room/view/chat_room_view.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/chat_room_view_model.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

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
