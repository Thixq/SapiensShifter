// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/chat_preview_view_model.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_meta_data.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_room_models/chat_info.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_room_models/chat_with_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/context_menu.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/new_chat_bottom_sheet.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part '../mixin/chat_preview_view_mixin.dart';
part 'widget/chat_view_app_bar.dart';
part 'widget/chat_view_chat_list.dart';

@RoutePage()
class ChatPreviewView extends StatefulWidget {
  const ChatPreviewView({super.key});

  @override
  State<ChatPreviewView> createState() => _ChatPreviewViewState();
}

class _ChatPreviewViewState extends BaseState<ChatPreviewView>
    with ChatPreviewViewMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: <Widget>[
            _bulildAppBar(),
            _buildChatList(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ChatPreviewViewModel, ChatPreviewState> _buildChatList() {
    return BlocBuilder<ChatPreviewViewModel, ChatPreviewState>(
      builder: (context, state) => ChatViewChatList(
        onDismissed: (id) {
          viewModel.softDeleteChat(chatId: id);
        },
        onTap: (chatRoomId) {
          context.router.push(
            ChatRoomRoute(
              id: chatRoomId,
            ),
          );
        },
        chatList:
            state.searchedChats.isEmpty ? state.chats : state.searchedChats,
        otherUsers: state.allUsers,
        currentUserId: getUserId,
      ),
    );
  }

  BlocBuilder<ChatPreviewViewModel, ChatPreviewState> _bulildAppBar() {
    return BlocBuilder<ChatPreviewViewModel, ChatPreviewState>(
      builder: (context, state) => ChatViewAppBar(
        menuGlobalKey: menuGlobalKey,
        searchController: _searchController,
        menuOnPressed: menuOnPressed,
        newChatOnPressed: () async {
          if (mounted) {
            final user = await NewChatBottomSheet.show(
              context,
              peopleList: state.allUsers,
            );
            if (user != null) {
              final chat = newChat(user: user);
              final chatInfo = ChatInfo(
                chatName: user.name,
                chatImageUrl: user.photoUrl,
              );
              await context.router.push(
                ChatRoomRoute(
                  chatWithModel: ChatWithModel(
                    chatMetadata: chat,
                    chatInfo: chatInfo,
                  ),
                ),
              );
            }
          }
        },
        searchOnChanged: (value) {
          viewModel.searchChatName(text: value);
        },
        searchOnSubmitted: (value) {},
      ),
    );
  }
}
