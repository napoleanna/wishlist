import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wishlist/data/gift_reasons.dart';
import 'package:wishlist/widgets/app_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppTextField(
          controller: nameController,
          label: 'Wish name',
          icon: Icons.card_giftcard,
        ),
        const SizedBox(height: 15),

        DropdownButtonFormField<String>(
          value: selectedReason,
          decoration: InputDecoration(
            labelText: 'Reason for a gift',
            prefixIcon: const Icon(Icons.celebration, color: Colors.deepPurpleAccent),
            filled: true,
            fillColor: Colors.purple.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
          onChanged: onReasonChanged,
          items: GiftReasonHelper.giftReasons.map((reason) {
            return DropdownMenuItem(value: reason, child: Text(reason));
          }).toList(),
        ),
        const SizedBox(height: 15),

        AppTextField(
          controller: linkController,
          label: 'Wish link',
          icon: Icons.link,
        ),
        const SizedBox(height: 15),

        AppTextField(
          controller: notesController,
          label: 'Notes (color, size, etc.)',
          icon: Icons.notes,
        ),
        const SizedBox(height: 15),

        GestureDetector(
          onTap: onPickDate,
          child: AbsorbPointer(
            child: AppTextField(
              controller: dateController,
              label: 'Gift Date (dd.mm.yyyy)',
              icon: Icons.calendar_today,
            ),
          ),
        ),

        CheckboxListTile(
          title: const Text('Remember this date'),
          value: rememberDate,
          activeColor: Colors.deepPurple,
          contentPadding: EdgeInsets.zero,
          onChanged: onRememberDateChanged,
        ),
        const SizedBox(height: 24),

        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6d66b1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(isEditing ? 'Update Wish' : 'Save Wish',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}