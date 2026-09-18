import 'package:material_ui/material_ui.dart';
import 'package:wishlist/widgets/wishlist_header_icon.dart';

class CreateWishlistDialog extends StatefulWidget {
  const CreateWishlistDialog({
    super.key,
  });

  @override
  State<CreateWishlistDialog> createState() =>
      _CreateWishlistDialogState();
}

class _CreateWishlistDialogState extends State<CreateWishlistDialog> {

  final TextEditingController _titleController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
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
    final theme = Theme.of(context);
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    final dialogBackground = isDarkMode
        ? const Color(0xFF211D2B)
        : const Color(0xFFFCFAFF);

    final secondaryTextColor = isDarkMode
        ? Colors.white70
        : const Color(0xFF6F6A78);

    final borderColor = isDarkMode
        ? primaryColor.withValues(alpha: 0.7)
        : const Color(0xFFD1BFFF);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 460,
          ),
           child: Stack(
             clipBehavior: Clip.none,
             children: [
               Container(
                 width: double.infinity,
                 padding: const EdgeInsets.fromLTRB(26, 88, 26, 28),
                 decoration: BoxDecoration(
                   color: dialogBackground,
                   borderRadius: BorderRadius.circular(28),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withValues(alpha: 0.18),
                       blurRadius: 35,
                       offset: const Offset(0, 14),
                     ),
                   ],
                 ),
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                   Text(
                     'Create a Wishlist',
                     textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.w700,
                     color: isDarkMode ? Colors.white : const Color(0xFF15131A),
                     letterSpacing: -0.4,
                     ),
                   ),
                     const SizedBox(height: 10),
                     Text(
                       'What is this wishlist for?',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w400,
                         color: secondaryTextColor,
                       ),
                     ),
                     const SizedBox(height: 26),
                     TextField(
                       controller: _titleController,
                       focusNode: _focusNode,
                       autofocus: true,
                       textCapitalization:
                          TextCapitalization.sentences,
                       textInputAction: TextInputAction.done,

                       style: TextStyle(
                         fontSize: 16,
                         color: isDarkMode
                             ? Colors.white
                             : const Color(0xFF25212B),
                     ),
                       decoration: InputDecoration(
                         hintText: 'Give your wishlist a cool name',
                         hintStyle: TextStyle(
                           fontSize: 16,
                           color: isDarkMode
                               ? Colors.white38
                               : const Color(0xFF9A95A3),
                         ),

                         prefixIcon: Icon(
                           Icons.list_alt_rounded,
                           size: 24,
                           color: isDarkMode
                               ? Colors.white70
                               : const Color(0xFF686170),
                         ),
                         filled: true,
                         fillColor: isDarkMode 
                             ? Colors.white.withValues(alpha: 0.04) 
                             : const Color(0xFFFCFAFF),

                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 16,
                           vertical: 18,
                         ),

                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(
                             color: borderColor,
                             width: 1.5,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                             borderRadius:
                             BorderRadius.circular(20),
                             borderSide: BorderSide(
                               color: primaryColor,
                               width: 2,
                         ),
                        ),
                       ),
                       onSubmitted: (_) => _createWishlist(),
                     ),
                     const SizedBox(height: 18),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(
                           Icons.auto_awesome_rounded,
                           size: 19,
                           color: primaryColor,
                         ),
                         const SizedBox(width: 9),
                         Expanded(
                             child: Text(
                               'This wish needs a wishlist before it can be saved.',
                               style: TextStyle(
                                 fontSize: 13.5,
                                 height: 1.35,
                                 fontWeight: FontWeight.w500,
                                 color: primaryColor,
                               ),
                             ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 28),
                     Row(
                       children: [
                         Expanded(
                             child: SizedBox(
                               height: 58,
                               child: OutlinedButton(
                                   onPressed: () => Navigator.pop(context),
                                   style: OutlinedButton.styleFrom(
                                       foregroundColor: primaryColor,
                                       side: BorderSide(
                                         color:
                                         primaryColor.withValues(alpha: 0.65),
                                         width: 1.5,
                                       ),
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(30),
                                       ),
                                   ),
                                   child: const Text(
                                     'Cancel',
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                               ),
                             ),
                         ),
                         const SizedBox(width: 16),
                         Expanded(
                             child: SizedBox(
                               height: 58,
                               child: DecoratedBox(
                                   decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                       colors: [
                                         primaryColor,
                                         Color.lerp(
                                           primaryColor,
                                           Colors.purple,
                                           0.35,
                                         )!,
                                       ],
                                     ),
                                     borderRadius:
                                     BorderRadius.circular(30),

                                     boxShadow: [
                                       BoxShadow(
                                         color: primaryColor
                                             .withValues(alpha: 0.22),
                                         blurRadius: 12,
                                         offset:
                                         const Offset(0, 5),
                                       ),
                                     ],
                                   ),
                                 child: ElevatedButton(
                                   onPressed: _createWishlist,

                                   style: ElevatedButton.styleFrom(
                                     backgroundColor:
                                     Colors.transparent,
                                     shadowColor:
                                     Colors.transparent,

                                     shape:
                                     RoundedRectangleBorder(
                                       borderRadius:
                                       BorderRadius.circular(30),
                                     ),
                                   ),
                                   child: const Text(
                                     'Create',
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                              ),
                             ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               Positioned(
                 top: -18,
                 left: 0,
                 right: 0,
                 child: Center(
                   child: WishlistIcon(
                     primaryColor: primaryColor,
                   ),
                 ),
               ),
             ],
           ),
      ),
    );
  }
}

