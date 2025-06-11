import 'package:flutter/material.dart';
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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: .3.dp,
          height: 2.dp,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Text(
            'data',
            style: TextStyle(fontSize: 0.8.sp),
          ),
        ),
      ),
    );
  }
}
