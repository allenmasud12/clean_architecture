import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();

  static final MyApp instance =
      MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
