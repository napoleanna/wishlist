import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wishlist/screens/wish_creation_screen/widgets/wish_card_wrapper.dart';
import 'package:wishlist/screens/wish_creation_screen/widgets/wish_text_field.dart';

import 'wish_form_header.dart';
import 'wish_reason_field.dart';
import 'remember_date_card.dart';

class WishForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController linkController;
  final TextEditingController notesController;
  final TextEditingController dateController;
  final String? selectedReason;
  final bool rememberDate;
  final MaskTextInputFormatter dateMaskFormatter;
  final Function(String?) onReasonChanged;
  final ValueChanged<bool> onRememberDateChanged;
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

    final itemBgColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white;
    final iconBgColor = isDarkMode
        ? Colors.purple.shade900.withValues(alpha: 0.4)
        : Colors.purple.shade100.withValues(alpha: 0.7);

    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black54;

    final filledFieldsCount = _calculateProgress();


    return ListView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      children: [
       WishFormHeader(
           isEditing: isEditing,
           filledFieldsCount: filledFieldsCount,
       ),

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
          child: WishReasonField(
            selectedReason: selectedReason,
            onChanged: onReasonChanged,
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

        RememberDateCard(
          value: rememberDate,
          onChanged: onRememberDateChanged,
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