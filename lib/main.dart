import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const LustreJewelryApp());
}

class LustreJewelryApp extends StatelessWidget {
  const LustreJewelryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lustre Jewelry',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F4EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB08D57),
          brightness: Brightness.light,
        ),
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}