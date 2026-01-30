import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});


  Widget _buildFriendItem(String name, String avatarPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundImage: AssetImage(avatarPath)),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by name',
              prefixIcon: const Icon(Icons.search_outlined),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Friends: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox( height: 8),
          Column(
            children: [
              _buildFriendItem('Anna', 'assets/avatars/avatar1.png'),
              _buildFriendItem('Ivan', 'assets/avatars/avatar2.png'),
            ],
          )
        ],
      )
    );
  }
}
