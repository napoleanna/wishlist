import 'package:flutter/material.dart';
import '../../../data/gift_reasons.dart';

class WishlistFormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final String? selectedImage;
  final bool enableReservations;
  final bool isSaving;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<bool> onReservationsChanged;
  final VoidCallback onSave;

  const WishlistFormBody({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.selectedImage,
    required this.enableReservations,
    required this.isSaving,
    required this.onTitleChanged,
    required this.onReservationsChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final customButtonColor = Color(0xFF7C64D1);
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black54;
    final cardColor = isDarkMode ? Colors.white.withValues(alpha: 0.05)
        : Colors.white;
    final customTextColor = isDarkMode ? Colors.white
        : const Color(0xFF140A37);

    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8A7FE4).withValues(
                      alpha: isDarkMode ? 0.25 : 0.4),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
              child: Image.asset(
                'assets/images/gift_box_screensaver .png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.card_giftcard,
                  size: 64,
                  color: Color(0xFF6d66b1),
                ),
            ),
          ),
          ),
          const SizedBox(height: 24),

          Center(
            child: Text(
              'Create wish list',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customTextColor,
            ),
           ),
          ) ,
          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: isDarkMode ? [] : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wish list Name',
                style: TextStyle(fontWeight: FontWeight.bold,
                color: customTextColor,
                fontSize: 15,
                 ),
                ),
                const SizedBox(height: 12),
                Autocomplete<String>(
                    optionsBuilder: (textValue) =>
                    GiftReasonHelper.giftReasons.where((opt) =>
                        opt.toLowerCase().contains(textValue.text.toLowerCase())),
                  onSelected: onTitleChanged,
                  fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
                      if (controller.text != titleController.text) {
                        controller.text = titleController.text;
                      }
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        style: TextStyle(color: isDarkMode ? Colors.white
                            : Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Birthday, Wedding, etc.',
                          hintStyle: TextStyle(
                            color: secondaryTextColor.withValues(alpha: 0.6),
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.white10
                              : Colors.purple.shade50.withValues(alpha: 0.5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        ),
                        onChanged: (val) {
                          titleController.text = val;
                          onTitleChanged(val);
                        },
                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Please enter a name' : null,
                      );
                  },
                ),
              ],
            ),
          ),
         const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
                borderRadius: BorderRadius.circular(24),
              boxShadow: isDarkMode ? [] : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enable Reservations',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: customTextColor )),
                        Text('See when someone has reserved a wish?',
                            style: TextStyle(
                                color: customTextColor, fontSize: 12)),
                      ],
                    ),
                ),
                Switch.adaptive(
                    value: enableReservations,
                    onChanged: onReservationsChanged,
                    activeTrackColor: customButtonColor,
                    activeThumbColor: Colors.white,
                    inactiveTrackColor: isDarkMode ? Colors.white12
                        : Colors.black12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: customButtonColor,
                  elevation: 2,
                  shadowColor: customButtonColor.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                child: isSaving 
                 ? const CircularProgressIndicator(color: Colors.white)
                 : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 25),
                      SizedBox(width: 8),
                      Text('Create List', style: TextStyle(
                           fontSize: 18,
                           color: Colors.white,
                           fontWeight: FontWeight.bold)),
                ],
            ),
           ),
          )
        ],
      ),
    );
  }
}