import 'package:flutter/material.dart';
import 'package:justdigital_webapp/core/themes/app_theme.dart';
import 'package:justdigital_webapp/core/widgets/custom_appbar.dart';
import 'package:justdigital_webapp/core/widgets/questions_slider.dart';
import 'package:justdigital_webapp/core/constants/questions.dart';
import 'package:justdigital_webapp/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Digital SAS',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Just Digital - Tutela de Salud'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
   return HomePage();
}
}