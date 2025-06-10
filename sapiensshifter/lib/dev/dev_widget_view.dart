import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio_viewer.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';

void main() {
  runApp(
    const MaterialApp(
      home: DevHome(),
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
      body: Center(
        child: CustomRadioViewer(
          itemList: [
            CustomRadioModel(
              value: 1,
              widget: CircleAvatar(
                backgroundImage: NetworkImage(''.ext.randomImage),
              ),
            ),
            CustomRadioModel(value: 2, widget: const Text('Option 2')),
            CustomRadioModel(value: 3, widget: const Text('Option 3')),
            CustomRadioModel(
              value: 4,
              widget: CircleAvatar(
                backgroundImage: NetworkImage(''.ext.randomImage),
              ),
            ),
            CustomRadioModel(value: 5, widget: const Text('Option 5')),
          ],
          onChange: (value) {
            // Handle value change
            print('Selected value: $value');
          },
        ),
      ),
    );
  }
}
