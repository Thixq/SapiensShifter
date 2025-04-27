import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_preview_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/chat_view_app_bar.dart';
part 'widget/chat_view_chat_list.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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
            onDismissed: (id) {
              print('Chat Preview Id: $id');
            },
            onTap: (chatRoomId) {
              print('Chat Room Id: $chatRoomId');
            },
            chatList: [
              ChatPreviewModel(
                id: 'ChatPreviewId1',
                chatRoomId: 'ChatRoomId1',
                personName: 'Aliço',
                groupName: 'Grup İndirimi',
                imageUrl: ''.ext.randomImage,
                lastMessage: 'Merhaba',
                lastMessageTime: DateTime(2025, 4, 20, 12, 54, 43),
              ),
              ChatPreviewModel(
                id: 'ChatPreviewId2',
                chatRoomId: 'chatRoomId2',
                personName: 'Aliço',
                imageUrl: ''.ext.randomImage,
                lastMessage: 'Merhaba',
                lastMessageTime: DateTime.now(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
