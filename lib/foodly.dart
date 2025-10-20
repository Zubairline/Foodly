import 'package:flutter/material.dart';
import 'package:foodly_backup/core/routes.dart';

class Foodly extends StatelessWidget {
  const Foodly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodly',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
