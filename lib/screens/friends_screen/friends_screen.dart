import 'package:flutter/material.dart';
import 'package:wishlist/screens/friends_screen/widgets/friends_list.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('My Friends',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF1F1F2E)),
                ),
                SizedBox(width: 8),
                Icon(Icons.auto_awesome, color: Color(0xFF7B61FF), size: 24),
              ],
            ),
            Text('People who make gifting special ♡',
             style: TextStyle(
               fontFamily: 'Poppins',
               fontSize: 14,
               color: Color(0xFF6B6B8A),
               fontWeight: FontWeight.w400,
             ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        
      ),
      body: const FriendsList(),
    );

   }
}
