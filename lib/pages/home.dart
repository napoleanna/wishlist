import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishlist/pages/login_screen.dart';
import 'package:wishlist/pages/search_screen.dart';
import 'package:wishlist/pages/notifications_screen.dart';
import 'package:wishlist/pages/profile_screen.dart';
import 'package:wishlist/pages/wishlist_screen.dart';
import 'package:wishlist/services/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;


  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }





  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      WishListScreen(),
      SearchScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'lib/assets/images/${themeNotifier.value == ThemeMode.light
                  ? 'background.webp'
                  : 'background_dark.webp'}'
          ),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My profile'),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}