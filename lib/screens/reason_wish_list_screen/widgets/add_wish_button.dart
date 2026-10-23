import 'package:material_ui/material_ui.dart';

import '../../wish_creation_screen/wish_creation_screen.dart';

class AddWishButton extends StatelessWidget {
  final String userId;
  final String listId;

  const AddWishButton({
    super.key,
    required this.userId,
    required this.listId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WishCreationScreen(
                userId: userId,
                initialListId: listId,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.add,
          size: 26,
        ),
        label: const Text(
          'Add Wish',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B78D1),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xFF8E6BBE)
              .withValues(alpha: 0.30),
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}