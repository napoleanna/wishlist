import 'package:material_ui/material_ui.dart';
import 'package:wishlist/data/gift_reasons.dart';

import 'gift_icon_helper.dart';


class WishReasonField extends StatelessWidget {
  final String? selectedReason;
  final ValueChanged<String?> onChanged;

  const WishReasonField({
    super.key,
    required this.selectedReason,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    const primaryColor = Color(0xFF6D66B1);

    final iconBgColor = isDarkMode
        ? Colors.purple.shade900.withValues(alpha: 0.4)
        : Colors.purple.shade100.withValues(alpha: 0.7);

    final secondaryTextColor =
    isDarkMode ? Colors.white60 : Colors.black54;

    return DropdownButtonFormField<String>(
      initialValue: selectedReason,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black87,
        fontSize: 16,
      ),

      dropdownColor: isDarkMode ? const Color(0xFF1D1636) : Colors.white,
      borderRadius: BorderRadius.circular(24),

      icon: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: secondaryTextColor,
          size: 22,
        ),
      ),

      decoration: InputDecoration(
        labelText: 'Reason for a gift',
        labelStyle: TextStyle(
          color: secondaryTextColor,
          fontSize: 14,
        ),

        prefixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: iconBgColor,
              child: const Icon(
                Icons.celebration,
                color: primaryColor,
                size: 18,
              ),
            ),
        ),

        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,

        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: onChanged,
        selectedItemBuilder: (context) {
        return  GiftReasonHelper.giftReasons
            .map(
              (reason) => Text(
            reason,
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white
                  : Colors.black87,
              fontSize: 16,
            ),
          ),
        ).toList();
        },
      items: GiftReasonHelper.giftReasons.map(
            (reason) {
          final isSelected = reason == selectedReason;

          return DropdownMenuItem<String>(
            value: reason,
            child: Container(
              height: 48,
              padding:
              const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    GiftIconHelper.getReasonIcon(reason),
                    color: isSelected
                        ? primaryColor
                        : secondaryTextColor,
                    size: 22,
                  ),

                  const SizedBox(width: 14),

                  Text(
                    reason,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),

                  const Spacer(),

                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: primaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}