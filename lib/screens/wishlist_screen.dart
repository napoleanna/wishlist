import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/widgets/wish_card.dart';
import 'login_screen.dart';
import 'package:wishlist/screens/wish_creation_screen.dart';


class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const ProfileHeader(),
            buildTabs(),
            Expanded(
              child: TabBarView(
                children: [
                  WishListView(filterByOccasion: true),
                  WishListView(filterByOccasion: false),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFc39ac5),
      title: const Text('Wish List'),
      actions: [
        IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  LoginScreen()),
            );
          },
          icon: const Icon(Icons.exit_to_app),
        )
      ],
    );
  }

  Widget buildTabs() {
    return const TabBar(
        indicatorColor: Color(0xFFac829d),
        labelColor: Color(0xFF8a4f75),
        unselectedLabelColor: Color(0xFF3b2848),
      tabs: [
        Tab(text: 'Occasion'),
        Tab(text: 'All wishes'),
      ],
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFFD8BFD8),
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WishCreationScreen(initialProductName: ''))
        );
      },
      child: const Icon(Icons.add, size: 40, color: Colors.white60),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://img.freepik.com/premium-photo/anime-girl-with-pink-hair-blue-eyes-sitting-train-generative-ai_974521-19657.jpg'),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Anna',
                style: TextStyle(
                    color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Friends 20', style: TextStyle(color: Colors.white60)),
            ],
          )
        ],
      ),
    );
  }
}

class WishListView extends StatelessWidget {
  final bool filterByOccasion;

  const WishListView({super.key, required this.filterByOccasion});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('User not logged in'));
  }
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid).collection('wishes')
      .orderBy('created_at', descending: true)
      .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      final wishes = snapshot.data!.docs;

      final filteredWishes = filterByOccasion
      ? wishes.where((doc) => (doc['reason'] as String).isNotEmpty).toList()
      : wishes;

    if (filteredWishes.isEmpty) {
      return const Center(child: Text('No wishes found'));
  }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: filteredWishes.length,
      itemBuilder: (context, index) {
       var wish = filteredWishes[index];
       return WishCard(
         title: wish['name'] ?? 'No name',
         reason: (wish['reason'] ?? '') as String,
         link: (wish['link'] ?? '') as String,
         notes: (wish['notes'] ?? '') as String,
         date: (wish['created_at'] as Timestamp?)?.toDate().toLocal().toString().split(' ').first,
       );

      },
    );
    },
    );
  }
}
