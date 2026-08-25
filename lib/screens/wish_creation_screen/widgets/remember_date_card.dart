import 'package:material_ui/material_ui.dart';

class RememberDateCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RememberDateCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    const primaryColor = Color(0xFF6D66B1);

    final itemBgColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.06) : Colors.white;

    final iconBgColor = isDarkMode
        ? Colors.purple.shade900.withValues(alpha: 0.4)
        : Colors.purple.shade100.withValues(alpha: 0.7);

    final secondaryTextColor = isDarkMode ? Colors.white60 : Colors.black54;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: itemBgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconBgColor,
            child: const Icon(
              Icons.notifications_none_outlined,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Remember this date',
                     style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.bold,
                       color: isDarkMode ? Colors.white : Colors.black87,
                     ),
                  ),
                  const SizedBox(height: 2),
                  Text('Get a reminder before the special day',
                     style: TextStyle(
                       fontSize: 12,
                       color: secondaryTextColor,
                     ),
                  ),
                ],
              ),
          ),
          Switch(
              value: value,
              activeThumbColor: Colors.white,
              activeTrackColor: primaryColor,
              inactiveThumbColor:
                isDarkMode ? Colors.white12 : Colors.black12,
              onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
