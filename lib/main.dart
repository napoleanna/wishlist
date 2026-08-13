import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wishlist/app/theme/theme.dart';
import 'package:wishlist/screens/loading_screen/loading_screen.dart';
import 'package:wishlist/screens/profile_screen/profile_screen.dart';
import 'package:wishlist/services/auth_wrapper.dart';
import 'package:wishlist/services/theme_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ThemeService.initTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WishList',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          themeMode: themeMode,

          routes: {
            '/loading' : (context) => const LoadingScreen(),
            '/profile' : (context) => const ProfileScreen(),
          },
          home: const AuthWrapper(),
        );
      },
    );
  }
}

