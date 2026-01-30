import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/screens/main_wish_screen/main_wish_screen.dart';
import 'package:wishlist/screens/friends_screen/friends_screen.dart';
import 'package:wishlist/screens/profile_screen/profile_screen.dart';
import 'widgets/add_menu_bottom_sheet.dart';
import 'widgets/home_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const MainWishScreen(),
    const FriendsScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    if (index == 2) {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => AddMenuBottomSheet(userId: userId),
      );
      return;
    }
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    int screenIndex = selectedIndex;
    if (selectedIndex == 3) {
      screenIndex = 2;
    } else if (selectedIndex == 2) {
      screenIndex = 0;
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: screenIndex,
        children: screens,
      ),
      bottomNavigationBar: HomeBottomBar(
        selectedIndex: selectedIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}