import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SapiensTheme.instance.lightTheme,
      home: Thix(),
    );
  }
}

class Thix extends StatelessWidget {
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        alignment: Alignment.center,
        height: 200,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("data"),
            )
          ],
        ),
      ),
    ));
  }
}
