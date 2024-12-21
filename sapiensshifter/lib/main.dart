// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/utils/dialog/sapi_counter_dialog.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/nav_bar_export.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Aysel git başımdan'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: 25,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PreviewTableCard(
                          dataModel: TableModel(
                            tableName: 'Masa 12',
                            peopleCount: 1,
                            timeStamp: DateTime.now(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: PreviewTableCard(
                          dataModel: TableModel(
                            tableName: 'Masa 12',
                            peopleCount: 1,
                            timeStamp: DateTime.now(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: context.general.mediaQuery.padding.bottom,
              ),
              child: CustomNavBar(
                items: [
                  NavBarItem(icon: Icons.message),
                  NavBarItem(
                    icon: Icons.table_bar,
                    onPress: () => context.popupManager.showLoader(
                      barrierDismissible: true,
                      widgetBuilder: (context) => SapiCounterDialog(
                        titleName: 'Masa 12',
                        buttonText: 'Onayla',
                        onPressed: print,
                      ),
                    ),
                  ),
                  NavBarItem(icon: Icons.ssid_chart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
