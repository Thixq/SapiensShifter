import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/chat_view_app_bar.dart';
part 'widget/chat_view_chat_list.dart';

@RoutePage()
class ChatPreviewView extends StatefulWidget {
  const ChatPreviewView({super.key});

  @override
  State<ChatPreviewView> createState() => _ChatPreviewViewState();
}

class _ChatPreviewViewState extends State<ChatPreviewView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          ChatViewAppBar(
            searchController: _searchController,
            menuOnPressed: () {},
            newChatOnPressed: () {},
            searchOnChanged: (value) {},
            searchOnSubmitted: (value) {},
          ),
          ChatViewChatList(
            onDismissed: (id) {},
            onTap: (chatRoomId) {},
            chatList: const [],
          ),
        ],
      ),
    );
  }
}
