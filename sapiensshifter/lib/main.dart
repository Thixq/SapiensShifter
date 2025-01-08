import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/price_editing_card.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/func/price_editing_func.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    LanguageManager(
      child: const MyApp(),
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
        home: const Thix(),
      ),
    );
  }
}

class Thix extends StatefulWidget {
  const Thix({super.key});

  @override
  State<Thix> createState() => _ThixState();
}

class _ThixState extends State<Thix> {
  List<ProductModel> productlist = [
    ProductModel(
      id: '1',
      price: 10,
      productName: 'Caffee Latte',
      imagePath: ''.ext.randomImage,
    ),
    ProductModel(
      id: '2',
      price: 20,
      productName: 'Caffee Latte',
      imagePath: ''.ext.randomImage,
    ),
    ProductModel(
      id: '3',
      price: 10,
      productName: 'Caffee Latte',
      imagePath: ''.ext.randomImage,
    ),
    ProductModel(
      id: '4',
      price: 10,
      productName: 'Caffee Latte',
      imagePath: ''.ext.randomImage,
    ),
  ];
  final List<ProductModel> selectList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final changeLists = PriceEditingFunc.findAndOperate(
              value: 10,
              operations: Operations.PLUS,
              mainList: productlist,
              selectedList: selectList,
            );
            productlist = changeLists.mainChangeList;
          });
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: productlist.map(
              (productModel) {
                return PriceEditingCard(
                  productModel: productModel,
                  onPress: (productModel, isSelect) {
                    if (selectList.contains(productModel)) {
                      selectList.remove(productModel);
                      isSelect.value = false;
                    } else {
                      selectList.add(productModel);
                      isSelect.value = true;
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
