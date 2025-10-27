import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodly_backup/config/utils/colors.dart';
import 'package:foodly_backup/config/utils/routes.dart';

class Foodly extends StatelessWidget {
  const Foodly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodly',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.signIn,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: background),
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
