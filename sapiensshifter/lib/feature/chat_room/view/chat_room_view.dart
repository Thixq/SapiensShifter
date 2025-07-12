import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';

import 'package:sapiensshifter/feature/chat_room/view_model/chat_room_view_model.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/state/chat_room_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/chat_room_view_app_bar.dart';
part 'widget/chat_room_chat_content.dart';
part 'widget/chat_bubble.dart';
part 'widget/message_text_field.dart';
part '../mixin/chat_room_view_mixin.dart';

@RoutePage()
class ChatRoomView extends StatefulWidget {
  const ChatRoomView({
    required this.chatWithState,
    super.key,
  });

  final ChatWithState chatWithState;

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

  BlocBuilder<ChatRoomViewModel, ChatWithState> _buildContent() {
    return BlocBuilder<ChatRoomViewModel, ChatWithState>(
      builder: (context, state) {
        return ChatContent(
          messages: state is ChatLoaded ? state.messages : [],
          currentUserId: userProfile.user?.userPreviewId,
        );
      },
    );
  }

  BlocListener<ChatRoomViewModel, ChatWithState> _buildMessageArea() {
    return BlocListener<ChatRoomViewModel, ChatWithState>(
      listener: (context, state) {},
      child: MessageTextField(
        controller: controller,
        send: () async {
          // await viewModel.writeMessage(
          //   text: controller.text.trimRight(),
          // );
          // await viewModel.saveChat();
          controller.clear();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: BlocBuilder<ChatRoomViewModel, ChatWithState>(
        builder: (context, state) {
          return ChatRoomViewAppBar(
            imageUrl: state.chatInfo?.chatImageUrl,
            title: state.chatInfo?.chatName,
          );
        },
      ),
    );
  }
}
