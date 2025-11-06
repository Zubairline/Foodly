import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/foodly.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIChangeCallback((systemOverlayAreVisible) async {
    if (!systemOverlayAreVisible) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  });

  final startWidget = await getInitialScreen();

  FlutterNativeSplash.remove();
  HydratedBloc.storage = storage;
  runApp(Foodly(initialRoute: startWidget));
}

Future<String> getInitialScreen() async {
  final auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();

  final user = auth.currentUser;
  final lastActive = prefs.getInt('last_active');

  if (user == null) {
    return RouteGenerator.signIn;
  }

  if (lastActive != null) {
    final lastActiveDate = DateTime.fromMillisecondsSinceEpoch(lastActive);
    final diff = DateTime.now().difference(lastActiveDate).inDays;
    if (diff >= 14) {
      await auth.signOut();
      prefs.remove('last_active');
      return RouteGenerator.signIn;
    }
  }

  await prefs.setInt('last_active', DateTime.now().millisecondsSinceEpoch);
  return RouteGenerator.initialRoute;
}
