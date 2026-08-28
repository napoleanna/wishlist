import 'package:material_ui/material_ui.dart';

class CreateWishlistDialog extends StatefulWidget {
  const CreateWishlistDialog({
    super.key,
  });

  @override
  State<CreateWishlistDialog> createState() =>
      _CreateWishlistDialogState();
}

class _CreateWishlistDialogState
    extends State<CreateWishlistDialog> {

  final TextEditingController _titleController =
  TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _createWishlist() {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a wishlist name'),
        ),
      );
      return;
    }

    Navigator.pop(context, title);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        8,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        24,
        8,
        24,
        10,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        16,
      ),

      title: const Text(
        'Create a Wishlist',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'What is this wishlist for?',
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode
                  ? Colors.white70
                  : Colors.black54,
            ),
          ),

          const SizedBox(height: 18),

          TextField(
            controller: _titleController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'e.g. Promotion',
              prefixIcon: Icon(
                Icons.list_alt_rounded,
                color: isDarkMode
                    ? Colors.white70
                    : Colors.black54,
              ),
              filled: true,
              fillColor: isDarkMode
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.04),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onSubmitted: (_) => _createWishlist(),
          ),

          const SizedBox(height: 12),

          Text(
            'This wish needs a wishlist before it can be saved.',
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? Colors.white54
                  : Colors.black45,
            ),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: _createWishlist,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Create',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}