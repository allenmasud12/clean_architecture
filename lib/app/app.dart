import 'package:clean_architecture/presentation/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();
  int appState = 0;
  static  MyApp instance =
      MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
