// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/preview_order_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';
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
            Padding(
              padding: EdgeInsets.all(16),
              child: PreviewOrderCard(
                orderModelList: [
                  OrderModel(
                    imagePath: 'https://coffee.alexflipnote.dev/random',
                    extras: ['Laktozsuz', 'Bitter Çikolatalı Süt Reçeli'],
                    price: 123.01,
                    deliveryStatus: DeliveryStatus.HERE_IN,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
