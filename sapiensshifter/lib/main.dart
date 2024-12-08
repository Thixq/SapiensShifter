// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/preview_table_card_widget/preview_table_card.dart';
import 'package:sapiensshifter/product/models/preview_table_card_model.dart';
import 'package:sizer/sizer.dart';

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
  Thix({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PreviewTableCard(
                    onPressed: (dataModel) {
                      debugPrint(dataModel.tableName);
                    },
                    dataModel: PreviewTableCardModel(
                      tableName: ' Masa 12',
                      timeStamp: DateTime.now(),
                      peopleCount: 1,
                    ),
                  ),
                  PreviewTableCard(
                    dataModel: PreviewTableCardModel(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
