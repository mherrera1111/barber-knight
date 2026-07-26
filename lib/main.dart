import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'views/home_view.dart';

void main() {
  runApp(const BarberKnightApp());
}

class BarberKnightApp extends StatelessWidget {
  const BarberKnightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Knight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.midnightBlue,
        primaryColor: AppColors.goldenPalm,
      ),
      home: const HomeView(),
    );
  }
}