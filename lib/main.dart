import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/profile.dart';
import 'screens/forgot_password_page.dart';
import 'l10n/app_localizations.dart';
import 'blocs/language_bloc.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => LanguageBloc(), child: const FoodlyApp()),
  );
}

class FoodlyApp extends StatelessWidget {
  const FoodlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Foodly',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'OpenSans',
            scaffoldBackgroundColor: const Color(0xFFFAF6F3),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFEB7A50),
            ),
            useMaterial3: true,
          ),
          // Localization
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
            Locale('fr'), // French
            Locale('de'), // German
          ],
          // initial screen
          initialRoute: '/signup',

          // route configuration
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/profile': (context) =>
                const ProfileScreen(userEmail: 'default@example.com'),
            '/forgot-password': (context) => const ForgotPasswordPage(),
          },
        );
      },
    );
  }
}
