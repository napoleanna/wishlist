import 'dart:io';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController nicknameController;
  final DateTime? birthDate;
  final String selectedAvatar;
  final List<String> avatarPaths;
  final VoidCallback onPickDate;
  final ValueChanged<String> onAvatarChanged;
  final VoidCallback onPickFromGallery;
  final Future<void> Function() onSave;
  final bool isSaving;

  const ProfileForm({
    super.key,
    required this.nicknameController,
    required this.birthDate,
    required this.selectedAvatar,
    required this.avatarPaths,
    required this.onPickDate,
    required this.onAvatarChanged,
    required this.onPickFromGallery,
    required this.onSave,
    this.isSaving = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = const Color(0xFF6d66b1);
    final textColor = isDark ? Colors.white : Colors.black87;
    final fieldFillColor = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white;


    Widget buildSmallAvatar(String path) {
      final isSelected = path == selectedAvatar;
      return GestureDetector(
        onTap: () => onAvatarChanged(path),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? accentColor : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: CircleAvatar(backgroundImage: AssetImage(path)),
        ),
      );
    }


    return Column(
      children: [
        Center(
          child: CircleAvatar(
              radius: 65,
              backgroundColor: accentColor.withValues(alpha: 0.1),
              backgroundImage: selectedAvatar.startsWith('assets')
                  ? AssetImage(selectedAvatar) as ImageProvider
                  : FileImage(File(selectedAvatar)),
          ),
        ),

        const SizedBox(height: 10),
        Text(
            'Choose avatar:', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor)),
        const SizedBox(height: 15),


        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSmallAvatar(avatarPaths[0]),
                const SizedBox(width: 10),
                buildSmallAvatar(avatarPaths[1]),
                const SizedBox(width: 10),
                buildSmallAvatar(avatarPaths[2]),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSmallAvatar(avatarPaths[3]),
                const SizedBox(width: 10),
                buildSmallAvatar(avatarPaths[4]),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onPickFromGallery,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1.5),
                    ),
                    child: Icon(Icons.add_a_photo_outlined, color: accentColor, size: 22),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        TextField(
          controller: nicknameController,
          decoration: InputDecoration(
            labelText: 'Nickname',
            filled: true,
            fillColor: fieldFillColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: accentColor.withValues(alpha: 0.2), width: 2)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: accentColor, width: 2.5)),
          ),
        ),

        const SizedBox(height: 12),

        InkWell(
          onTap: onPickDate,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: fieldFillColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    birthDate == null ? 'Select birth date' : 'Birth date: ${birthDate!.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16, color: birthDate == null ? Colors.grey : null),
                  ),
                ),
                Icon(Icons.calendar_today, color: accentColor, size: 20),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 0,
            ),
            onPressed: isSaving ? null : onSave,
            child: isSaving
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Save Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}