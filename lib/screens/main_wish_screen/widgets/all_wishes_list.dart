import 'package:flutter/material.dart';
import 'package:wishlist/firebase_data/firestore_service.dart';
import 'package:wishlist/models/wish.dart';
import 'package:wishlist/screens/wish_creation_screen/wish_creation_screen.dart';
import 'package:wishlist/widgets/wish_card.dart';

class AllWishesList extends StatefulWidget {
  const AllWishesList({
    super.key,
    required this.currentUserId,
    required this.allWishesStream,
  });

  final String currentUserId;
  final Stream<List<Wish>> allWishesStream;

  @override
  State<AllWishesList> createState() => _AllWishesListState();
}

class _AllWishesListState extends State<AllWishesList>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Wish>>(
      stream: widget.allWishesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final wishes = snapshot.data ?? [];
        if (wishes.isEmpty) {
          return const Center(child: Text('No wishes yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: wishes.length,
          itemBuilder: (context, index) => WishCard(
            wish: wishes[index],
            onDelete: () => FirestoreService().deleteWish(
              widget.currentUserId,
              wishes[index].id,
            ),
            onEdit: () =>
                _openEditWish(context, wishes[index], widget.currentUserId),
          ),
        );
      },
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
