part of '../shift_add_view.dart';

class BranchAndShift extends StatelessWidget {
  const BranchAndShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pazartesi'),
        context.sized.emptySizedHeightBoxLow,
        Row(
          children: [
            Expanded(
              child: SapiCustomDropDown(
                hintText: 'Shift',
                items: const {'Açılış': 12, 'Kapanış': 24},
                onSelected: (select) {
                  print('value $select');
                },
              ),
            ),
            context.sized.emptySizedWidthBoxLow3x,
            Expanded(
              child: SapiCustomDropDown(
                hintText: 'Şube',
                items: const {'Kanyon': 12, 'Karaköy': 24},
                onSelected: (select) {
                  print('value $select');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
