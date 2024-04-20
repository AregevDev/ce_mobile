import 'package:ce_mobile/pages/welcome_page.dart';
import 'package:flutter/material.dart';

import 'main.mapper.g.dart' show initializeJsonMapper;

void main() {
  initializeJsonMapper();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightGreen, brightness: Brightness.dark),
          brightness: Brightness.dark,
          useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const WelcomePage(),
    );
  }
}
