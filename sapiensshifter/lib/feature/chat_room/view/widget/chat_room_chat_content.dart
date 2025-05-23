part of '../chat_room_view.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({
    this.currentUserId,
    this.messages,
    super.key,
  });

  final List<MessageModel>? messages;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        top: context.sized.normalValue,
      ),
      reverse: true,
      clipBehavior: Clip.none,
      itemCount: messages?.length,
      itemBuilder: (context, index) {
        final currentUser = messages?[index].senderId == currentUserId;

        return Container(
          alignment: currentUser ? Alignment.centerRight : Alignment.centerLeft,
          margin: EdgeInsets.only(
            bottom: context.sized.lowValue,
          ),
          child: ChatBubble(
            text: messages?[index].text,
            currentUser: currentUser,
          ),
        );
      },
    );
  }
}
