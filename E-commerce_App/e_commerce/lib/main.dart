// filepath: c:\Users\user\Documents\From_Github2\GDG_group_5_Capstone_Project\E-commerce_App\e_commerce\lib\main.dart
import 'package:flutter/material.dart';
import 'package:e_commerce/core/routing/app.router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
