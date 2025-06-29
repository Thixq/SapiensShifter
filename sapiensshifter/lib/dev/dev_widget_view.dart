import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/sapi_custom_drop_down/model/sapi_drop_down_model.dart';

import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

void main() {
  runApp(
    MaterialApp(
      home: Sizer(
        builder: (p0, p1, p2) => const DevHome(),
      ),
    ),
  );
}

class DevHome extends StatefulWidget {
  const DevHome({super.key});

  @override
  State<DevHome> createState() => _DevHomeState();
}

class _DevHomeState extends State<DevHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Home'),
      ),
      body: SapiCustomDropDown(
        hintText: 'Selecet',
        items: List.generate(
          12,
          (index) => SapiDropDownModel(
            displayName: 'displayName$index',
            value: index,
          ),
        ),
        onSelected: print,
      ),
    );
  }
}
