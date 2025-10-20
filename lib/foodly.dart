import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly_backup/core/colors.dart';
import 'package:foodly_backup/core/routes.dart';

class Foodly extends StatelessWidget {
  const Foodly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodly',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.initialRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          actionsIconTheme: IconThemeData(size: 20),
          toolbarHeight: 50,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
    );
  }
}
