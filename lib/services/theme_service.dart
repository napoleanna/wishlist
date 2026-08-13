import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'user_theme_mode';
  static final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);

  static Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedTheme = prefs.getString(_themeKey);

    if (savedTheme == 'dark') {
      themeNotifier.value = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      themeNotifier.value = ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.system;
    }
  }

  static Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;

    themeNotifier.value = newMode;
    await prefs.setString(_themeKey, isDark ? 'dark' : 'light');
  }
}

ValueNotifier<ThemeMode> get themeNotifier => ThemeService.themeNotifier;

