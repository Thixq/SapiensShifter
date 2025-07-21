part of '../chat_room_view.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    required TextEditingController controller,
    required this.send,
    super.key,
  }) : _controller = controller;

  final TextEditingController _controller;
  final VoidCallback send;

  double get _blurValue => 10;
  Color get _containerColor => const Color.fromARGB(
        100,
        0,
        0,
        0,
      );

  @override
  Widget build(BuildContext context) {
    return _buildMessageFieldBlurArea(context);
  }

  ClipRect _buildMessageFieldBlurArea(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurValue, sigmaY: _blurValue),
        child: _buildMessageAreaAnimatedPadding(context),
      ),
    );
  }

  AnimatedPadding _buildMessageAreaAnimatedPadding(BuildContext context) {
    return AnimatedPadding(
      duration: Duration.zero,
      padding: EdgeInsets.only(
        bottom: context.general.keyboardPadding,
      ),
      child: _buildMessageAreaContainer(context),
    );
  }

  Container _buildMessageAreaContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.lowValue,
      ),
      decoration: BoxDecoration(
        color: _containerColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildMessageArea(context),
        ),
      ),
    );
  }

  Widget _buildMessageArea(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(context),
        ),
        context.sized.emptySizedWidthBoxLow,
        _buildSendButton(),
      ],
    );
  }

  IconButton _buildSendButton() {
    return IconButton.filled(
      onPressed: _send,
      icon: const Icon(Icons.send),
    );
  }

  void _send() {
    if (_controller.text.trim().isNotEmpty) {
      send();
    }
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 3,
      controller: _controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade700,
        filled: true,
        isDense: true,
        hintText: 'Mesajınız...',
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(context.sized.normalValue),
        ),
      ),
    );
  }
}
