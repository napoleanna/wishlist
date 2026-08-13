import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/screens/friends_screen/widgets/friend_requests_list.dart';
import 'package:wishlist/screens/friends_screen/widgets/profile_search_dialog.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  
  static void showSearchDialog(BuildContext context) {
    showDialog(
        context: context,
       builder: (context) => AlertDialog(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
         contentPadding:  EdgeInsets.zero,
         content: const ProfileSearchDialog(),
       )
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = const Color(0xFF6d66b1);
    final currentUser = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Quick search...',
              hintStyle:  TextStyle(color: Colors.grey.withValues(alpha: 0.7),
              fontFamily: 'Poppins'),
              prefixIcon: Icon(Icons.search, color: accentColor),
              suffixIcon: Icon(Icons.tune, color: Color(0xFF6d66b1)),
              filled: true,
              fillColor:
              isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildActionCard(
            context,
            icon: Icons.person_add_alt_1,
            title: 'Find new friends',
            subtitle: 'Invite or discover friends',
            onTap: () => showSearchDialog(context),
            accentColor: accentColor,
          ),

          const FriendRequestsList(),

          Text('Friends List', style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1F1F2E),
           ),
          ),
          const SizedBox(height: 15),

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .collection('friends')
                  .snapshots(),
              builder:  (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final friends = snapshot.data!.docs;
                if (friends.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Your friends list is empty.\nTry to find someone!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: friends.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final friendData = friends[index].data() as Map<
                        String, dynamic>;
                    return _buildFriendTile(
                      isDark: isDark,
                      name: friendData['name'] ?? 'No name',
                      avatar: friendData['avatar'] ??
                          'assets/avatars/avatar1.png',
                      subtitle: 'Check their wish lists',
                    );
                  },
                );
              },
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color accentColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? accentColor.withValues(alpha: 0.15)
              : accentColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(24),
          border: isDark ? Border.all(
              color: accentColor.withValues(alpha: 0.3),
              width: 1.5 ) : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isDark ? Colors.white.withValues(alpha: 0.12)
                  : Colors.white,
              radius: 26,
              child: Icon(icon, color: const Color(0xFF7B61FF), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: isDark ? Colors.white : const Color(0xFF2D264B))),
                  Text(subtitle, style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: isDark ? Colors.white.withValues(alpha: 0.6)
                          : const Color(0xFF6B6B8A))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? Colors.white70 : const Color(0xFF6B6B8A)),
          ],
        ),
      ),
    );
  }


  Widget _buildFriendTile({
    required bool isDark,
    required String name,
    required String avatar,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F1F2E).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          )
        ]
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(name, style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : const Color(0xFF1F1F2E),
                )),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                      color: isDark ? Colors.white.withValues(alpha: 0.6)
                          : const Color(0xFF6B6B8A),)),
                ],
              ),
          ),
          const Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 28,),
        ],
      ),
    );
  }

}
