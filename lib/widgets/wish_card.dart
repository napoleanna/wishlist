import 'package:flutter/material.dart';
import '../models/wish.dart';

class WishCard extends StatelessWidget {
  final Wish wish;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WishCard({
    super.key,
    required this.wish,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(wish.id),
      background: _buildBackground(Alignment.centerLeft, const Color(0xFFC5F4FC), Icons.edit),
      secondaryBackground: _buildBackground(Alignment.centerRight, const Color(0xFFF9959F), Icons.delete),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          onDelete();
          return true;
        } else {
          onEdit();
          return false;
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          leading: const Icon(Icons.card_giftcard, color: Color(0xFF5126AA)),
          title: Text(wish.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: wish.notes != null ? Text(wish.notes!) : null,
          trailing: wish.reason != null
              ? Chip(label: Text(wish.reason!), backgroundColor: const Color(0xFFEEE5FF))
              : null,
        ),
      ),
    );
  }

  Widget _buildBackground(Alignment alignment, Color color, IconData icon) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white),
    );
  }
}