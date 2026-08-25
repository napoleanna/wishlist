import 'package:material_ui/material_ui.dart';


class WishFormHeader extends StatelessWidget {
  final bool isEditing;
  final int filledFieldsCount;

  const WishFormHeader({
    super.key,
    required this.isEditing,
    required this.filledFieldsCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    const primaryColor = Color(0xFF6D66B1);

    final percentage = filledFieldsCount * 20;

    return Column(
      children: [
        const SizedBox(height: 35),

        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8A7FE4).withValues(
                    alpha: isDarkMode ? 0.25 : 0.4,
                ),
                blurRadius: 30,
                spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset('assets/images/gift_box_screensaver .png',
              fit:  BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                 return const Icon(
                   Icons.card_giftcard,
                   size: 64,
                   color: primaryColor,
                 );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          isEditing ? 'Edit Wish' : 'Create Wish',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5, (index) {
                final isFilled = index < filledFieldsCount;

                return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isFilled ? 32 : 24,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: isFilled
                          ? primaryColor
                          : (isDarkMode ? Colors.white24 : Colors.black12),
                    ),
                );
          },
          ),
        ),
        const SizedBox(height: 8),

        Text(
          '$percentage% completed',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
