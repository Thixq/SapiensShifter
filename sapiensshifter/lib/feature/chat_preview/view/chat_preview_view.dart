// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_preview/mixin/chat_preview_view_mixin.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/chat_preview_view_model.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';

import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/new_chat_bottom_sheet.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

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
          viewModel.deleteChat(id);
        },
        onTap: (chatRoomId) {},
        chatList: state.chatPreviews,
        otherUsers: state.userPreviewList,
        currentUserId: getProfileId,
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
          // TODO(kaan): Chat view oluştur.
          if (mounted) {
            await NewChatBottomSheet.show(
              context,
              peopleList: state.userPreviewList,
            );
          }
        },
        searchOnChanged: (value) {},
        searchOnSubmitted: (value) {},
      ),
    );
  }
}
