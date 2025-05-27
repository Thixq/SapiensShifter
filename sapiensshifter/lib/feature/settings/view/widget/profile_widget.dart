part of '../settings_view.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    required this.onImagePicked,
    this.user,
    super.key,
  });

  double get profileRadius => 48.sp;
  final SapiensUser? user;

  final VoidCallback onImagePicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CustomCircleAvatar(
              radius: profileRadius,
              imageUrl: user?.imagePath,
            ),
            Positioned(
              bottom: profileRadius * -0.01,
              right: profileRadius * -0.01,
              child: IconButton.filled(
                onPressed: onImagePicked,
                icon: const Icon(Icons.camera_alt_outlined),
                color: context.general.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
        Text(
          user?.name ?? '',
          style: context.general.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          user?.email ?? '',
          style: context.general.textTheme.labelSmall!
              .copyWith(fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
