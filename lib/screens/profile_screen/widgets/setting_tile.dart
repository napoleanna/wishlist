import 'package:material_ui/material_ui.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color contentColor;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    required this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4)
          ),
        ]
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6d66b1)),
        title: Text(
          title,
          style: TextStyle(
            color: contentColor,
            fontWeight: FontWeight.w500
          ),
        ),
        trailing: trailing
            ?? const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: onTap,
      ),
    );
  }
}
