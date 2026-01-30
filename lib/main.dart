import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/screens/loading_screen/loading_screen.dart';
import 'package:wishlist/screens/main_wish_screen/main_wish_screen.dart';
import 'package:wishlist/screens/profile_screen/profile_screen.dart';
import 'package:wishlist/services/theme_service.dart';
import 'app/theme/colors.dart';
import 'firebase_data/auth_checker.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (context, themeMode, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/loading': (context) => const LoadingScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
            theme: ThemeData(
              brightness: Brightness.light,
              colorSchemeSeed: Colors.deepPurple,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: AppColors.lightPurple,
                selectedItemColor: Colors.deepPurple,
                unselectedItemColor: Colors.white,
              ),

            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.deepPurple,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: AppColors.darkPurple,
                selectedItemColor: Colors.deepPurple,
                unselectedItemColor: Colors.white,
              ),
            ),
            themeMode: themeMode,
            home: AuthChecker(),
          );
        }
    );
  }
}

