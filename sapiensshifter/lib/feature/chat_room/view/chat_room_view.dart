import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_room/mixin/chat_room_view_mixin.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/chat_room_view_model.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/chat_room_view_app_bar.dart';
part 'widget/chat_room_chat_content.dart';
part 'widget/chat_bubble.dart';
part 'widget/message_text_field.dart';

@RoutePage()
class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, this.chatId, this.chatModel});

  final String? chatId;
  final ChatModel? chatModel;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends BaseState<ChatRoomView>
    with ChatRoomViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatRoomViewModel>(
      create: (context) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(),
        body: _buildContent(),
        bottomNavigationBar: _buildMessageArea(),
      ),
    );
  }

  BlocBuilder<ChatRoomViewModel, ChatRoomState> _buildContent() {
    return BlocBuilder<ChatRoomViewModel, ChatRoomState>(
      builder: (context, state) {
        return ChatContent(
          messages: state.messages,
          currentUserId: userProfile.user?.userPreviewId,
        );
      },
    );
  }

  BlocListener<ChatRoomViewModel, ChatRoomState> _buildMessageArea() {
    var isExist = false;
    return BlocListener<ChatRoomViewModel, ChatRoomState>(
      listenWhen: (previous, current) => current.isExist != previous.isExist,
      listener: (context, state) {
        isExist = state.isExist;
      },
      child: MessageTextField(
        controller: controller,
        send: () async {
          if (!isExist) {
            await viewModel.saveChat();
          }
          await viewModel.writeMessage(
            text: controller.text.trimRight(),
          );
          controller.clear();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: BlocBuilder<ChatRoomViewModel, ChatRoomState>(
        buildWhen: (previous, current) =>
            current.otherUserPreview != previous.otherUserPreview,
        builder: (context, state) {
          return ChatRoomViewAppBar(
            imageUrl: state.chatModel.isGroup
                ? state.chatModel.groupImageUrl
                : state.otherUserPreview?.photoUrl,
            title: state.chatModel.isGroup
                ? state.chatModel.groupName
                : state.otherUserPreview?.name,
          );
        },
      ),
    );
  }
}
