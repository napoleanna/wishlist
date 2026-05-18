import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String avatarPath;
  final String nickname;
  final DateTime? birthDate;
  final VoidCallback onEdit;

  const ProfileHeader ({
    super.key,
    required this.avatarPath,
    required this.nickname,
    required this.birthDate,
    required this.onEdit,
});



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = const Color(0xFF6d66b1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment:  Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 50, backgroundImage: AssetImage(avatarPath)),
              const SizedBox( height: 12),
              Text(
                nickname.isNotEmpty ? nickname: 'Your name',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                birthDate != null
                    ? 'Birth date: ${birthDate!.toLocal().toString().split(' ')[0]}'
                    : 'No date selected',
                style:  TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white60 : Colors.grey),
              ),
            ],
          ),
          Positioned(
            top: 0,
              right: 0,
              child: IconButton(
                  onPressed: onEdit,
                  icon:  Icon(
                      Icons.edit,
                      color: isDark ? Colors.white70 : accentColor),
              ),
          )
        ],
      ),
    );
  }
}
