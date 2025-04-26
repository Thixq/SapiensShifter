part of '../shift_view.dart';

final class ToDayTitle extends StatelessWidget {
  const ToDayTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;
    final day = DateFormat.d(langCode).format(DateTime.now());
    final month = DateFormat.MMMM(langCode).format(DateTime.now());

    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '$day ',
          style: const TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: month,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
