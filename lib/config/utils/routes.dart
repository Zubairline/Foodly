import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/widgets/navigation_decider.dart';
import 'package:foodly_backup/features/auth/forgot_password/managers/forgot_password_bloc.dart';
import 'package:foodly_backup/features/auth/forgot_password/screen/forgot_password.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_bloc.dart';
import 'package:foodly_backup/features/auth/sign_in/screen/sign_in.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_bloc.dart';
import 'package:foodly_backup/features/auth/sign_up/screen/signup.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_bloc.dart';
import 'package:foodly_backup/features/course_detail/screen/course_detail.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_bloc.dart';
import 'package:foodly_backup/features/discovery/screen/discovery.dart';
import 'package:foodly_backup/features/profile/screens/profile.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_bloc.dart';
import 'package:foodly_backup/features/recipes/screen/recipe_detail.dart';

class RouteGenerator {
  static const String profile = '/profile';
  static const String discovery = '/discovery';
  static const String shop = '/shop';
  static const String plan = '/plan';
  static const String courses = '/courses';
  static const String setting = '/settings';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String onboarding = '/onboarding';
  static const String initialRoute = '/initialRoute';
  static const String recipeDetail = '/recipeDetail';
  static const String courseContent = '/courseContent';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final args = settings.arguments;
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInBloc(auth),
            child: SignIn(),
          ),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpBloc(auth),
            child: SignUp(),
          ),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordBloc(auth),
            child: ForgotPassword(),
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (context) => Profile());
      case initialRoute:
        return MaterialPageRoute(builder: (context) => CustomNavBar());
      case discovery:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DiscoveryBloc(),
            child: Discovery(),
          ),
        );
      case recipeDetail:
        final recipeName = args as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RecipeDetailBloc(),
            child: RecipeDetailScreen(recipeName: recipeName),
          ),
        );
      case courseContent:
        final course = args as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CourseDetailBloc(),
            child: CourseDetailScreen(courseId: course,),
          ),
        );

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
