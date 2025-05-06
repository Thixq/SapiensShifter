part of '../chat_preview_view.dart';

class ChatViewChatList extends StatelessWidget {
  const ChatViewChatList({
    required this.chatList,
    required this.onDismissed,
    required this.onTap,
    required this.otherUsers,
    super.key,
    this.currentUserId,
  });

  final List<ChatPreviewModel> chatList;
  final List<UserPreviewModel> otherUsers;
  final String? currentUserId;
  final void Function(String chatRoomId) onTap;
  final void Function(String id) onDismissed;
  String get _nullText => LocaleKeys.null_value_null_name.tr();

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
                chatList[index].chatPreviewId ?? _nullText,
              ),
            ),
            children: [
              SlidableAction(
                onPressed: (context) => onDismissed(
                  chatList[index].chatPreviewId ?? _nullText,
                ),
                backgroundColor: CupertinoColors.systemRed,
                foregroundColor: CupertinoColors.white,
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
          child: _listTile(context, chatList[index], index),
        ),
        childCount: chatList.length,
      ),
    );
  }

  Widget _listTile(BuildContext context, ChatPreviewModel preview, int index) {
    return CupertinoListTile(
      padding: EdgeInsets.symmetric(
        vertical: context.sized.lowValue,
        horizontal: context.sized.normalValue,
      ),
      title: Text(
        preview.isGroup
            ? (preview.groupName ?? _nullText)
            : (_getOhterUser(preview, currentUserId: currentUserId)?.name ??
                _nullText),
      ),
      subtitle: Text(
        preview.lastMessageText ?? _nullText,
      ),
      leadingSize: 24.spa,
      leading: CustomCircleAvatar(
        imageUrl: preview.isGroup
            ? preview.groupImageUrl
            : _getOhterUser(preview, currentUserId: currentUserId)?.imageUrl,
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

  UserPreviewModel? _getOhterUser(
    ChatPreviewModel preview, {
    String? currentUserId,
  }) {
    return otherUsers.firstWhere(
      (element) =>
          element.userPreviewId ==
          preview.getOhterUserId(currentUserId: currentUserId),
    );
  }
}
