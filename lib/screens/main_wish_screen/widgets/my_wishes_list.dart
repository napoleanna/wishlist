import 'package:flutter/material.dart';
import 'package:wishlist/data/gift_reasons.dart';
import 'package:wishlist/models/reason_tile.dart';
import 'package:wishlist/models/wish_list.dart';
import 'package:wishlist/screens/reason_wish_list_screen/reason_wish_list_screen.dart';
import 'package:wishlist/screens/wish_creation_screen/wish_creation_screen.dart';
import 'package:wishlist/widgets/empty_state_widget.dart';

class MyWishesList extends StatefulWidget {
  const MyWishesList({
    super.key,
    required this.filteredWishlistsStream,
    required this.currentUserId,
  });

  final String currentUserId;
  final Stream<List<Wishlist>> filteredWishlistsStream;

  @override
  State<MyWishesList> createState() => _MyWishesListState();
}

class _MyWishesListState extends State<MyWishesList>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Wishlist>>(
      stream: widget.filteredWishlistsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Wishlist> activeLists = snapshot.data ?? [];
        if (activeLists.isEmpty) return _buildEmptyState();

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: activeLists.length,
          itemBuilder: (context, index) {
            return ReasonTile(
              reason: activeLists[index].title,
              imagePath:
                  GiftReasonHelper.reasonImages[activeLists[index].reason] ??
                  'assets/gift_reasons/other_occasion.webp',
              onTap: () => _navigateToReasonScreen(activeLists[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      title: 'No active wish lists.',
      icon: Icons.filter_list_off,
      actionLabel: 'Add your first wish',
      onActionPressed: () => _openCreateWish(context, widget.currentUserId),
    );
  }

  void _navigateToReasonScreen(Wishlist list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReasonWishListScreen(
          listId: list.id,
          title: list.title,
          userId: widget.currentUserId,
        ),
      ),
    );
  }

  void _openCreateWish(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WishCreationScreen(userId: userId)),
    );
  }
}
