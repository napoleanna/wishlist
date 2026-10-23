import 'package:material_ui/material_ui.dart';
import 'package:wishlist/models/wish.dart';

import '../../firebase_data/firestore_service.dart';
import '../../widgets/wish_card.dart';
import '../wish_creation_screen/wish_creation_screen.dart';
import 'widgets/add_wish_button.dart';
import 'widgets/reason_wish_list_header.dart';

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
    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: const Color(0xFFF0EEFF),

      body: SafeArea(
        child: StreamBuilder<List<Wish>>(
          stream: firestoreService.getWishesByListId(
            userId,
            listId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final wishes = snapshot.data ?? [];

            return Column(
              children: [
                ReasonWishListHeader(
                  title: title,
                  wishCount: wishes.length,
                ),

                Expanded(
                  child: wishes.isEmpty
                      ? _buildEmptyState()
                      : _buildWishList(
                    context,
                    wishes,
                    firestoreService,
                  ),
                ),
              ],
            );
          },
        ),
      ),

      floatingActionButton: AddWishButton(
        userId: userId,
        listId: listId,
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildWishList(
      BuildContext context,
      List<Wish> wishes,
      FirestoreService firestoreService,
      ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        100,
      ),
      itemCount: wishes.length,
      itemBuilder: (context, index) {
        final wish = wishes[index];

        return WishCard(
          wish: wish,
          onEdit: () => _openEditWish(
            context,
            wish,
          ),
          onDelete: () => firestoreService.deleteWish(
            userId,
            wish.id,
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 80,
        ),
        child: Text(
          'No wishes yet',
          style: TextStyle(
            color: Color(0xFF8E79A8),
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  void _openEditWish(
      BuildContext context,
      Wish wish,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WishCreationScreen(
          userId: userId,
          existingWish: wish,
        ),
      ),
    );
  }
}