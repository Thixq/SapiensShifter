part of '../chat_view.dart';

class ChatViewChatList extends StatelessWidget {
  const ChatViewChatList({
    required this.chatList,
    required this.onDismissed,
    required this.onTap,
    super.key,
  });

  final List<ChatPreviewModel> chatList;
  final void Function(String chatRoomId) onTap;
  final void Function(String id) onDismissed;
  String get _nullText => LocaleKeys.null_value.tr();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: .2,
            dismissible: DismissiblePane(
              onDismissed: () => onDismissed(
                chatList[index].id ?? _nullText,
              ),
            ),
            children: [
              SlidableAction(
                onPressed: (context) => onDismissed(
                  chatList[index].id ?? _nullText,
                ),
                backgroundColor: CupertinoColors.systemRed,
                foregroundColor: CupertinoColors.white,
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
          child: _listTile(context, chatList[index]),
        ),
        childCount: chatList.length,
      ),
    );
  }

  Widget _listTile(BuildContext context, ChatPreviewModel preview) {
    return CupertinoListTile(
      padding: EdgeInsets.symmetric(
        vertical: context.sized.lowValue,
        horizontal: context.sized.normalValue,
      ),
      title: Text(
        preview.groupName ?? preview.personName ?? _nullText,
      ),
      subtitle: Text(
        preview.lastMessage ?? _nullText,
      ),
      leadingSize: 24.spa,
      leading: CustomCircleAvatar(
        imageUrl: preview.imageUrl,
      ),
      trailing: Text(
        preview.lastMessageTime?.sapiTimeExt.lastMessageTime ?? _nullText,
        style: const TextStyle(color: CupertinoColors.systemGrey),
      ),
      onTap: () {
        onTap.call(preview.chatRoomId ?? _nullText);
      },
    );
  }
}
