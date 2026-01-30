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
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (selectedImage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(selectedImage!, height: 120, width: 120, fit: BoxFit.cover),
                ),
              ),
            ),

          Text(
            'Wish list Name',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5126AA), fontSize: 16),
          ),
          const SizedBox(height: 8),
          Autocomplete<String>(
            optionsBuilder: (textValue) {
              if (textValue.text.isEmpty) return GiftReasonHelper.giftReasons;
              return GiftReasonHelper.giftReasons.where((opt) =>
                  opt.toLowerCase().contains(textValue.text.toLowerCase()));
            },
            onSelected: onTitleChanged,
            fieldViewBuilder: (context, textController, focusNode, onSubmitted) {

              if (textController.text != titleController.text) {
                textController.text = titleController.text;
              }
              return TextFormField(
                controller: textController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Birthday, Wedding, etc.',
                  filled: true,
                  fillColor: Colors.purple.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                onChanged: (val) {
                  titleController.text = val;
                  onTitleChanged(val);
                },
                validator: (val) => (val == null || val.isEmpty) ? 'Please enter a name' : null,
              );
            },
          ),

          const SizedBox(height: 32),


          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Enable Reservations',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5126AA))),
                    const Text('See when someone has reserved a wish?',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Switch.adaptive(
                value: enableReservations,
                onChanged: onReservationsChanged,
                activeThumbColor: const Color(0xFFc39ac5),
                activeTrackColor: const Color(0xFFc39ac5).withValues(alpha: 0.5),
              ),
            ],
          ),

          const SizedBox(height: 48),

          Center(
            child: isSaving
                ? const CircularProgressIndicator(color: Color(0xFFc39ac5))
                : ElevatedButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Create List', style: TextStyle(color: Colors.white, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5126AA),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}