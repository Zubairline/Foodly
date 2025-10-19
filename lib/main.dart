import 'package:flutter/material.dart';
import 'screens/discovery.dart'; 

void main() => runApp(const FoodlyApp());

class FoodlyApp extends StatelessWidget {
  const FoodlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodly',
      home: HomeScreen(),
    );
  }
}