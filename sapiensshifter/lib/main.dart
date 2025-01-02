// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_divider.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_rounded_shape_border.dart';

import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
<<<<<<< Updated upstream
import 'package:sapiensshifter/product/component/preview_order_card.dart';
=======
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/order_info_bottom_sheet.dart';
>>>>>>> Stashed changes
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) => MaterialApp(
        theme: SapiensTheme.instance.lightTheme,
        home: Thix(),
      ),
    );
  }
}

class Thix extends StatelessWidget {
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashedDivider(),
            Container(
              height: 100,
              width: 100,
              decoration: ShapeDecoration(
                shape: DashedRoundedShapeBorder(
                  cornerRadius: 12,
                  borderSide: BorderSide(),
                ),
              ),
              child: Text('data'),
            ),
          ],
        ),
      ),
=======
    return const Scaffold(
      body: Center(child: Blabla()),
    );
  }
}

class Blabla extends StatelessWidget {
  const Blabla({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('a'),
      onPressed: () {
        // ignore: inference_failure_on_function_invocation
        showModalBottomSheet<Widget>(
          context: context,
          builder: (BuildContext context) {
            return OrderInfoBottomSheet(
              tableModel: TableModel(
                tableName: 'O3',
                orderList: [
                  OrderModel(
                    orderName: 'Cortado',
                    imagePath: 'https://coffee.alexflipnote.dev/random',
                    price: 123,
                  ),
                  OrderModel(
                    orderName: 'Caffee Latte',
                    imagePath: 'https://coffee.alexflipnote.dev/random',
                    price: 200,
                  ),
                ],
              ),
            );
          },
        );
      },
>>>>>>> Stashed changes
    );
  }
}
