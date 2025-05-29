part of '../chat_room_view.dart';

final class ChatRoomViewAppBar extends StatelessWidget {
  const ChatRoomViewAppBar({
    this.ohterUser,
    super.key,
  });

  final UserPreviewModel? ohterUser;
  String get nullName => LocaleKeys.null_value_null_name.tr();
  double get _blurFactor => 50;
  Color get _backgroundColor => const Color.fromARGB(
        100,
        0,
        0,
        0,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _blurFactor,
            sigmaY: _blurFactor,
          ),
          child: ColoredBox(
            color: _backgroundColor,
            child: FlexibleSpaceBar(
              title: Row(
                children: [
                  CustomCircleAvatar(
                    radius: 24.sp,
                    imageUrl: ohterUser?.photoUrl,
                  ),
                  context.sized.emptySizedWidthBoxLow3x,
                  Text(
                    ohterUser?.name ?? nullName,
                    style: context.general.textTheme.titleMedium,
                  ),
                ],
              ),
              centerTitle: false,
            ),
          ),
        ),
      ),
    );
  }
}
