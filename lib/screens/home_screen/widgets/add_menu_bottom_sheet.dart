import 'package:flutter/material.dart';
import 'package:wishlist/screens/wish_creation_screen/wish_creation_screen.dart';
import 'package:wishlist/screens/wishlist_creation_screen/wishlist_creation_screen.dart';

class AddMenuBottomSheet extends StatelessWidget {
  final String userId;

  const AddMenuBottomSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'What would you like to add?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5126AA),
              ),
            ),
          ),
          const Divider(height: 1),
          _buildOption(
            context,
            icon: Icons.card_giftcard,
            color: const Color(0xFFc39ac5),
            title: 'Add a New Wish',
            subtitle: 'Create a detailed wish item',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WishCreationScreen(userId: userId)),
            ),
          ),
          _buildOption(
            context,
            icon: Icons.folder_open,
            color: const Color(0xFF917AA2),
            title: 'New Wishlist/Occasion',
            subtitle: 'Create a custom category or event',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WishlistCreationScreen(userId: userId)),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2), // Сделал чуть мягче фон иконки
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(context); // Закрываем меню
        onTap(); // Переходим на экран
      },
    );
  }
}