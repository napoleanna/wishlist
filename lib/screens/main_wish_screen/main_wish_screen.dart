import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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
      _allWishesStream = _firestoreService.getWishesByUser(_currentUserId);
      _filteredWishlistsStream = Rx.combineLatest2(
        _firestoreService.getWishesByUser(_currentUserId),
        _firestoreService.getWishlistsByUser(_currentUserId), (wishes, wishlists) {
          return List<Wishlist>.from(wishlists).where((list) {
            return wishes.any((wish) => wish.reason == list.reason);
          }).toList();
        },
      );
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
    return AppBar(
      backgroundColor: const Color(0xFFc39ac5),
      title: const Text('My wishes'),
      bottom: const TabBar(
        tabs: [Tab(text: 'My wish lists'), Tab(text: 'All Wishes')],
      ),
    );
  }
}

  


