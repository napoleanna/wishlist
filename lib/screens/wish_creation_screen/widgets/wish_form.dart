import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wishlist/data/gift_reasons.dart';
import 'package:wishlist/screens/wish_creation_screen/widgets/wish_card_wrapper.dart';
import 'package:wishlist/screens/wish_creation_screen/widgets/wish_text_field.dart';
import 'gift_icon_helper.dart';


class WishForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController linkController;
  final TextEditingController notesController;
  final TextEditingController dateController;
  final String? selectedReason;
  final bool rememberDate;
  final MaskTextInputFormatter dateMaskFormatter;
  final Function(String?) onReasonChanged;
  final Function(bool?) onRememberDateChanged;
  final VoidCallback onPickDate;
  final VoidCallback onSave;
  final bool isEditing;

  const WishForm({
    super.key,
    required this.nameController,
    required this.linkController,
    required this.notesController,
    required this.dateController,
    required this.selectedReason,
    required this.rememberDate,
    required this.dateMaskFormatter,
    required this.onReasonChanged,
    required this.onRememberDateChanged,
    required this.onPickDate,
    required this.onSave,
    required this.isEditing,
  });

  int _calculateProgress() {
    int filledFields = 0;
    if (nameController.text.trim().isNotEmpty) filledFields++;
    if (selectedReason != null && selectedReason!.isNotEmpty) filledFields++;
    if (linkController.text.trim().isNotEmpty) filledFields++;
    if (notesController.text.trim().isNotEmpty) filledFields++;
    if (dateController.text.trim().isNotEmpty) filledFields++;
    return filledFields;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final itemBgColor = isDarkMode ? Colors.white.withValues(alpha: 0.06) : Colors.white;
    final iconBgColor = isDarkMode ? Colors.purple.shade900.withValues(alpha: 0.4) : Colors.purple.shade100.withValues(alpha: 0.7);
    final primaryColor = const Color(0xFF6d66b1);
    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black54;

    final filledFieldsCount = _calculateProgress();
    final percentage = filledFieldsCount * 20;

    return ListView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
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
                  color: const Color(0xFF8A7FE4).withValues(alpha: isDarkMode ? 0.25 : 0.4),
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
        const SizedBox(height: 16),
        Center(
          child: Text(
            isEditing ? 'Edit Wish' : 'Create Wish',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final isFilled = index < filledFieldsCount;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isFilled ? 32 : 24,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: isFilled ? primaryColor : (isDarkMode ? Colors.white24 : Colors.black12),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '$percentage% completed',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        const SizedBox(height: 24),

        WishCardWrapper(
          bgColor: itemBgColor,
          child: WishTextField(
            controller: nameController,
            label: 'Wish name',
            icon: Icons.card_giftcard,
            iconBgColor: iconBgColor,
          ),
        ),
        const SizedBox(height: 12),

        WishCardWrapper(
          bgColor: itemBgColor,
          child: ButtonTheme(
            alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                initialValue: selectedReason,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 16),
                dropdownColor: isDarkMode ? const Color(0xFF1D1636) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                     color: secondaryTextColor, size: 22),
                  ),
                decoration: InputDecoration(
                  labelText: 'Reason for a gift',
                  labelStyle: TextStyle(color: secondaryTextColor, fontSize: 14),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: iconBgColor,
                      child: Icon(Icons.celebration, color: primaryColor, size: 18),
                    ),
                  ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
               onChanged: onReasonChanged,
               selectedItemBuilder: (BuildContext context) {
                  return GiftReasonHelper.giftReasons.map<Widget>((String reason) {
                  return Text(reason, style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87, fontSize: 16),
                  );
               }).toList();
              },
              items: GiftReasonHelper.giftReasons.map((reason) {
                final isSelected = reason == selectedReason;
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          GiftIconHelper.getReasonIcon(reason),
                          color: isSelected ? primaryColor : secondaryTextColor,
                          size: 22,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          reason,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold 
                                : FontWeight.normal,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected) Icon(
                            Icons.check_circle_rounded,
                            color: primaryColor, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
              )
          ),
        ),
        const SizedBox(height: 12),

        WishCardWrapper(
          bgColor: itemBgColor,
          child: WishTextField(

            controller: linkController,
            label: 'Wish link',
            icon: Icons.link,
            iconBgColor: iconBgColor,
          ),
        ),
        const SizedBox(height: 12),

        WishCardWrapper(
          bgColor: itemBgColor,
          child: WishTextField(
            controller: notesController,
            label: 'Notes (color, size, etc.)',
            icon: Icons.edit_note,
            iconBgColor: iconBgColor,
          ),
        ),
        const SizedBox(height: 12),

        WishCardWrapper(
          bgColor: itemBgColor,
          child: WishTextField(
             controller: dateController,
             label: 'Gift Date (dd.mm.yyyy)',
             hintText: 'Choose date',
             icon: Icons.calendar_today_outlined,
             iconBgColor: iconBgColor,
             suffixIcon: IconButton(
               icon: Icon(Icons.calendar_month_outlined,
                color: secondaryTextColor, size: 20),
               onPressed: onPickDate,
             ),
             inputFormatters: [
               dateMaskFormatter,
             ],
            ),
          ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: itemBgColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isDarkMode ? [] : [
              BoxShadow(color: Colors.purple.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconBgColor,
                child: Icon(Icons.notifications_none_outlined, color: primaryColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remember this date',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87),
                    ),
                    const SizedBox(height: 2),
                    Text('Get a reminder before the special day', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                  ],
                ),
              ),
              Switch(
                value: rememberDate,
                activeThumbColor: Colors.white,
                activeTrackColor: primaryColor,
                inactiveTrackColor: isDarkMode ? Colors.white12 : Colors.black12,
                onChanged: (val) => onRememberDateChanged(val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF8A7FE4), Color(0xFF6D66B1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(color: const Color(0xFF6D66B1).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6)),
            ],
          ),
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Center(
                    child: Text(
                      isEditing ? 'Update Wish' : 'Create Wish',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}