import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/app/theme/colors.dart';
import 'package:wishlist/firebase_data/firestore_service.dart';
import 'package:wishlist/models/wish.dart';
import 'package:wishlist/models/wish_list.dart';
import 'package:wishlist/screens/main_wish_screen/widgets/all_wishes_list.dart';
import 'package:wishlist/screens/main_wish_screen/widgets/my_wishes_list.dart';

class MainWishScreen extends StatefulWidget {
  const MainWishScreen({super.key});

  @override
  State<MainWishScreen> createState() => _MainWishScreenState();
}

class _MainWishScreenState extends State<MainWishScreen> {
  final _firestoreService = FirestoreService();

  late Stream<List<Wish>> _allWishesStream;
  late Stream<List<Wishlist>> _filteredWishlistsStream;
  String _currentUserId = '';

  @override
  void initState() {
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (_currentUserId.isNotEmpty) {

      _allWishesStream = _firestoreService
          .getWishesByUser(_currentUserId);
      _filteredWishlistsStream = _firestoreService
          .getWishlistsByUser(_currentUserId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUserId.isEmpty) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: TabBarView(
          children: [
            MyWishesList(
              filteredWishlistsStream: _filteredWishlistsStream,
              currentUserId: _currentUserId,
            ),
            AllWishesList(
              currentUserId: _currentUserId,
              allWishesStream: _allWishesStream,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,

      title: const Text('My wishes',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [AppColors.darkAppBarGradientStart, AppColors.darkBg]
                : [AppColors.lightAppBarGradientStart, AppColors.lightBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
            child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isDark
                      ? AppColors.darkAccent
                      : AppColors.lightDeep,
                ),
              labelColor: isDark ? Colors.black : Colors.white,
              unselectedLabelColor: isDark
                  ? AppColors.darkText
                  : AppColors.lightDeep,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              labelPadding: const EdgeInsets.symmetric(horizontal: 26),
              tabs: const [
              Tab(text: 'My wish lists'),
              Tab(text: 'All Wishes'),
              ],
            ),
          ),
      ),
    );
  }
}

  


