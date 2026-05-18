import 'package:flutter/material.dart';
import 'package:wishlist/app/theme/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightDeep),
      bodyMedium: TextStyle(color: AppColors.lightDeep)
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightCard,
      selectedItemColor: AppColors.lightDeep,
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: const CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
    ),
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightDeep,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(color: AppColors.darkText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBg,
      selectedItemColor: AppColors.darkAccent,
      unselectedItemColor: AppColors.darkSurface,
    ),
    cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.darkText),
      trackColor: WidgetStateProperty.all(AppColors.darkSurface),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBg,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
  );

}