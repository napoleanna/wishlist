import 'package:flutter/material.dart';
import 'package:wishlist/services/theme_service.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  double notificationLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF392D75)),
          ),
        ),
        _buildSettingTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          trailing: Switch(
            value: themeNotifier.value == ThemeMode.dark,
            onChanged: (value) {
              setState(() => themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ),
        _buildSettingTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          trailing: Switch(
            value: notificationLevel == 1.0,
            onChanged: (value) => setState(() => notificationLevel = value ? 1.0 : 0.0),
          ),
        ),
        _buildSettingTile(
          icon: Icons.language_rounded,
          title: 'Language',
          onTap: () {},
        ),
        _buildSettingTile(
            icon: Icons.security_outlined,
            title: 'Privacy and Security',
            onTap: () {},
        ),
        _buildSettingTile(
          icon: Icons.currency_exchange_rounded,
          title: 'Currency',
          onTap: () { },
        ),
        const SizedBox(height: 20),
        const Padding(
            padding: EdgeInsets.only(
              left: 8,
              bottom: 12,
            ),
            child: Text(
              'Support',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF392D75)),
            ),
        ),
        _buildSettingTile(
          icon: Icons.coffee_rounded,
          title: 'Buy author a coffee',
          onTap: () {
            // Здесь можно открыть ссылку на донат или внутреннюю покупку
          },
        ),
        _buildSettingTile(
          icon: Icons.info_outline_rounded,
          title: 'About',
          onTap: () => _showAbout(context),
        ),
        const SizedBox(height: 100)
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6d66b1)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Wishlist App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 All rights reserved',
    );
  }
}