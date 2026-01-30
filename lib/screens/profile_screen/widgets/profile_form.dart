import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController nicknameController;
  final DateTime? birthDate;
  final String selectedAvatar;
  final List<String> avatarPaths;
  final VoidCallback onPickDate;
  final ValueChanged<String> onAvatarChanged;
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
    required this.onSave,
    this.isSaving = false,
});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(selectedAvatar),
          ),
          const SizedBox(height: 8),
          const Text('Choose avatar: '),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: avatarPaths.map((path) {
              final isSelected = path == selectedAvatar;
              return GestureDetector(
                onTap: () => onAvatarChanged(path),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(radius: 30,backgroundImage: AssetImage(path)),
                    if (isSelected)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.deepPurple,
                              width: 3),
                        ),
                      )
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                border: OutlineInputBorder(),
              ),
          ),
          const SizedBox(height:  16),
          ListTile(
            title: Text(
              birthDate == null
                  ? 'Select birth date'
                  : 'Birth date: ${birthDate!.toLocal().toString().split(' ')[0]}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: onPickDate,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: isSaving ? null : onSave,
                child: isSaving
                    ? const SizedBox(width:  18, height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2,
                      color:  Colors.white))
                        : const Text ('Save Profile'),
            ),
          ),
        ],
      ),
    );
  }


}