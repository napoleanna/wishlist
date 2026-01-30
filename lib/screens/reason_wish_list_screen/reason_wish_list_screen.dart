import 'package:flutter/material.dart';
import 'package:wishlist/models/wish.dart';
import '../../firebase_data/firestore_service.dart';
import '../../widgets/wish_card.dart';
import '../wish_creation_screen/wish_creation_screen.dart';

class ReasonWishListScreen extends StatelessWidget {
  final String listId;
  final String title;
  final String userId;

  const ReasonWishListScreen({
    super.key,
    required this.listId,
    required this.title,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final _firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishes for $title'),
        backgroundColor: const Color(0xFFC39AC5),
      ),
      body: StreamBuilder<List<Wish>>(
        stream: _firestoreService.getWishesByListId(userId, listId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final wishes = snapshot.data ?? [];
          if (wishes.isEmpty) {
            return const Center(child: Text('No wishes found in this list'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: wishes.length,
            itemBuilder: (context, index) {
              final wish = wishes[index];

              return WishCard(
                wish: wish,
                onEdit: () => _openEditWish(context, wish, userId),
                onDelete: () => _firestoreService.deleteWish(userId, wish.id),
              );
            },
          );
        },
      ),
    );
  }

  void _openEditWish(BuildContext context, Wish wish, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WishCreationScreen(userId: userId, existingWish: wish),
      ),
    );
  }
}
