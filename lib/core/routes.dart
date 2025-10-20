import 'package:flutter/material.dart';
import 'package:foodly_backup/config/widgets/navigation_decider.dart';
import 'package:foodly_backup/features/auth/forgot_password/screen/forgot_password.dart';
import 'package:foodly_backup/features/auth/sign_in/screen/sign_in.dart';
import 'package:foodly_backup/features/auth/sign_up/screen/signup.dart';
import 'package:foodly_backup/features/profile/screens/profile.dart';

class RouteGenerator {
  static const String profile = '/profile';
  static const String discovery = '/discovery';
  static const String shop = '/shop';
  static const String plan = '/plan';
  static const String cookBook = '/cookbook';
  static const String setting = '/settings';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String onboarding = '/onboarding';
  static const String initialRoute = '/initialRoute';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (context) => SignIn());
      case signUp:
        return MaterialPageRoute(builder: (context) => SignUp());
        case forgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case profile:
        return MaterialPageRoute(builder: (context) => Profile());
      case initialRoute:
        return MaterialPageRoute(builder: (context) => CustomNavBar());
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(child: Text('Something went wrong')),
    ),
  );
}
