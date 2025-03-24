part of '../sign_in_view.dart';

class SocialSignInButtons extends StatelessWidget {
  const SocialSignInButtons({required this.socialButtonList, super.key});

  final List<SocialButtonModel> socialButtonList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: socialButtonList
          .map(
            (item) => InkWell(
              overlayColor: WidgetStateColor.transparent,
              onTap: item.onPress,
              child: SvgAssetBuilder(
                builderSize: const Size(
                  50,
                  50,
                ),
                svgPath: item.path,
              ),
            ),
          )
          .toList(),
    );
  }
}
