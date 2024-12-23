// ignore_for_file: prefer_const_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/component/custom_nav_bar.dart';
import 'package:sapiensshifter/product/component/message_info_list_tile.dart';
import 'package:sapiensshifter/product/component/preview_product_card.dart';
import 'package:sapiensshifter/product/component/preview_table_card.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/component/sapi_custom_drop_down.dart';
import 'package:sapiensshifter/product/component/sapi_text_field.dart';
import 'package:sapiensshifter/product/component/week_card.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/nav_bar_export.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    LanguageManager(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) => MaterialApp(
        theme: SapiensTheme.instance.lightTheme,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
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
      body: ListView(
        children: [
          SapiButton(
            buttonText: LocaleKeys.confirm.tr(),
            onPressed: () {},
          ),
          SapiTextField(),
          CustomCircleAvatar(imageUrl: ''),
          CustomNavBar(items: [NavBarItem(icon: Icons.abc)]),
          MessageInfoListTile(
            imageUrl: '',
            onPressed: () {},
          ),
          PreviewProductCard(
            onPressed: (productId) {},
            imageUrl: 'imageUrl',
            productName: 'productName',
            productId: 'productId',
            price: 1,
          ),
          PreviewTableCard(dataModel: TableModel()),
          SapiCustomDropDown<String>(
            items: const {'Kaan': 'Kaan', 'Hey': 'Hat'},
            isMulti: true,
            onSelected: (select) {},
          ),
          Row(
            children: [
              WeekCard(),
              SizedBox(
                width: 16,
              ),
              WeekCard(),
            ],
          ),
        ],
      ),
    );
  }
}
