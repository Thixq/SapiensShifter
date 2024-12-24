// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_divider.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_rounded_shape_border.dart';

import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/preview_order_card.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

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
    );
  }
}
