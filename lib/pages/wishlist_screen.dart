import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_data/wish_list_data.dart';

import '../widgets/wish_card.dart';
import 'login_screen.dart';


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
                  WishListView(wishList: occasionWishes),
                  WishListView(wishList: allWishes),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(),
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

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFFD8BFD8),
      shape: const CircleBorder(),
      onPressed: () {
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
  final List<Map<String, String>> wishList;
  const WishListView({super.key, required this.wishList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: wishList.length,
      itemBuilder: (context, index) {
        return WishCard(
          title: wishList[index]['title']!,
          date: wishList[index]['date']!,
          wishesCount: wishList[index]['count']!,
        );
      },
    );
  }
}
