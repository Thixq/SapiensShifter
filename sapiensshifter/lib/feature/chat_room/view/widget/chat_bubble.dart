part of '../chat_room_view.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.currentUser,
    this.text,
    super.key,
  });

  final String? text;
  final bool currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 60.w),
      decoration: BoxDecoration(
        color: currentUser
            ? context.general.colorScheme.tertiary
            : context.general.colorScheme.tertiaryContainer,
        borderRadius: _buildBorderRadius(context, currentUser),
      ),
      padding: EdgeInsets.all(context.sized.lowValue),
      child: Text(
        text ?? '',
      ),
    );
  }

  BorderRadius _buildBorderRadius(BuildContext context, bool currentUser) {
    if (currentUser) {
      return BorderRadius.only(
        topLeft: Radius.circular(context.sized.normalValue),
        topRight: Radius.circular(context.sized.normalValue),
        bottomLeft: Radius.circular(context.sized.normalValue),
      );
    } else {
      return BorderRadius.only(
        topLeft: Radius.circular(context.sized.normalValue),
        topRight: Radius.circular(context.sized.normalValue),
        bottomRight: Radius.circular(context.sized.normalValue),
      );
    }
  }
}
